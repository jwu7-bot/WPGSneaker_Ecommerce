class ProductsController < ApplicationController
  def index
    @products = Product.order(:name).page(params[:page])
  end

  def show
    @category = Category.find(params[:id])
  end
end
