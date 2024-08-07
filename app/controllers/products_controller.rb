class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:search].present?
      @products = @products.where('name ILIKE ?', "%#{params[:search]}%")
    end

    if params[:category].present?
      @products = @products.where(category_id: params[:category])
    end

    if params[:categories].present?
      @products = @products.where(category_id: params[:categories])
    end

    if params[:filter].present?
      case params[:filter]
      when 'on_sale'
        @products = @products.where.not(sale_price: nil)
      when 'new'
        @products = @products.where('created_at >= ?', 3.days.ago)
      when 'recently_updated'
        @products = @products.where('updated_at >= ?', 3.days.ago)
      end
    end

    @products = @products.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end
end
