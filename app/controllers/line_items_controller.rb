class LineItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product])
    @line_item = @cart.add_product(product.id)
    @line_item.save

    redirect_to cart_path(@cart)
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    redirect_to cart_path(@cart), notice: 'Line item removed'
  end

  def decrement
    @line_item = LineItem.find(params[:id])
    @line_item.decrement_or_destroy
    redirect_to cart_path(@cart), notice: 'Line item removed'
  end

  private
  def set_cart
    if session[:cart_id].nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id
    else
        @cart = Cart.find(session[:cart_id])
    end
  end
end
