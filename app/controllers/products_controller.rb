class ProductsController < ApplicationController
  def index
    @products = Product.order(:name)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(:name)
  end
end
