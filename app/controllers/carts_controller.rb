class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
  end

  def add_item
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity ||= 0
    cart_item.quantity += params[:quantity].to_i
    cart_item.save
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart.'
  end
  def update_item
    cart_item = @cart.cart_items.find(params[:id])
    if params[:quantity].to_i == 0
      cart_item.destroy
      redirect_to cart_path, notice: 'Product removed from cart.'
    else
      cart_item.update(quantity: params[:quantity].to_i)
      redirect_to cart_path, notice: 'Cart updated.'
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
