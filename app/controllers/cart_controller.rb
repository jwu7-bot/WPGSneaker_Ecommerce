class CartController < ApplicationController
  def create
    # add an item to the cart
    # POST /cart the post data will be in params, so we can access
    # the product id via params[:id]
    logger.debug("Adding id #{params["id"]} to the cart")
  end

  def destroy
    # remove an item from the cart
    # DELETE /cart/:id, so the id will come from the path
    # and is accessible via the params[:id]
  end
end
