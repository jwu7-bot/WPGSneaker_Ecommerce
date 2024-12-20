class ProductsController < ApplicationController
  def index
    @products = Product.order(:name).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all
    @query = params[:query]
    @category_id = params[:category_id]

    @products = Product.all

    if @query.present?
      @products = @products.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%")
    end

    @products = @products.where(category_id: @category_id) if @category_id.present?

    @products = @products.page(params[:page]).per(12)
  end
end
