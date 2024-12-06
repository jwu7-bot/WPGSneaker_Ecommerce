class CartController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_order = @cart.orders.find_by(product_id: @product.id)
    if current_order && quantity > 0
      current_order.update(quantity:)
    elsif quantity <= 0
      current_order.destroy
    else
      @cart.orders.create(product: @product, quantity:)
      flash[:notice] = "Added to the cart"
    end

    redirect_to root_path
  end

  def remove
    Order.find_by(id: params[:id]).destroy

    redirect_to root_path
  end
end
