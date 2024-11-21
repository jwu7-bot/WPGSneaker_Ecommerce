class ProductsController < ApplicationController
  def index
    @products = Product.order(:name).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all
    @query = params[:query]
    @category_id = params[:category_id]

    @products = Product.all
    @products = @products.where("name ILIKE ? OR description ILIKE ?", "%#{@query}%", "%#{@query}%") if @query.present?
    @products = @products.where(category_id: @category_id) if @category_id.present?

    @products = @products.page(params[:page]).per(10)
  end
end
