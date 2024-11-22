class CartController < ApplicationController
  before_action :get_product, only: %i[create destroy]

  def create
    # add an item to the cart
    # POST /cart the post data will be in params, so we can access
    # the product id via params[:id]

    unless session[:cart].include?(@product.id)
      session[:cart] << @product.id
      flash[:notice] = "#{@product.name} was added to cart!"
    end

    redirect_to root_path
  end

  def destroy
    # remove an item from the cart
    # DELETE /cart/:id, so the id will come from the path
    # and is accessible via the params[:id]

    if session[:cart].include?(@product.id)
      session[:cart].delete(@product.id)
      flash[:notice] = "#{@product.name} was removed from cart!"
    end

    redirect_to root_path
  end

  private

  def get_product
    product_id = params[:id].to_i
    @product = Product.find(product_id)
  end
end
