class CartController < ApplicationController
  def create
    # add an item to the cart
    # POST /cart the post data will be in params, so we can access
    # the product id via params[:id]
    product_id = params[:id].to_i

    unless session[:cart].include?(product_id)
      session[:cart] << product_id
      flash[:notice] = "Item added to cart"
    end

    redirect_to root_path
  end

  def destroy
    # remove an item from the cart
    # DELETE /cart/:id, so the id will come from the path
    # and is accessible via the params[:id]
    product_id = params[:id].to_i
    if session [ :cart ].include?(product_id)
      session[:cart].delete(product_id)
      flash[:notice] = "Item was removed from cart!"
    end

    redirect_to root_path
  end
end
