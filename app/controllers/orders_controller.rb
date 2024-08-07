class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @addresses = current_user.addresses
    if @addresses.empty?
      redirect_to new_address_path, alert: 'Please add an address before placing an order.'
    else
      @address = current_user.addresses.find_by(id: params.dig(:order, :address_id)) || current_user.addresses.last
      @subtotal = calculate_subtotal
      @taxes = calculate_taxes(@address)
      @total = @subtotal + @taxes.values.sum
    end
  end

  def recalculate_totals
    @order = Order.new
    @addresses = current_user.addresses
    @address = current_user.addresses.find(params[:address_id])
    @subtotal = calculate_subtotal
    @taxes = calculate_taxes(@address)
    @total = @subtotal + @taxes.values.sum
    render :new
  end

  def create
    if current_user.cart.cart_items.empty?
      redirect_to cart_path, alert: 'Your cart is empty. Add items to the cart before proceeding to checkout.'
      return
    end

    @order = current_user.orders.build(order_params)
    @order.status = :pending
    @order.subtotal = calculate_subtotal
    @order.total_price = @order.subtotal + calculate_taxes(@order.address).values.sum

    if @order.save
      current_user.cart.cart_items.each do |item|
        @order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price)
      end
      current_user.cart.cart_items.destroy_all

      @order.calculate_taxes.each do |tax_name, tax_amount|
        tax_type = TaxType.find_by(name: tax_name)
        tax = @order.address.province.taxes.find_by(tax_type: tax_type)
        @order.order_taxes.create(tax_type: tax_type, tax_amount: tax_amount, tax_rate: tax.rate)
      end

      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:address_id)
  end

  def calculate_subtotal
    current_user.cart.cart_items.sum { |item| item.product.price * item.quantity }
  end

  def calculate_taxes(address)
    province = address.province
    applicable_taxes = province.taxes
    total_taxes = {}

    applicable_taxes.each do |tax|
      tax_amount = calculate_subtotal * (tax.rate / 100.0)
      total_taxes[tax.tax_type.name] ||= 0
      total_taxes[tax.tax_type.name] += tax_amount
    end

    total_taxes
  end

  def calculate_total(address)
    calculate_subtotal + calculate_taxes(address).sum { |_, v| v }
  end
end
