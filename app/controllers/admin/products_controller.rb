require "action_view"
include ActionView::Helpers::NumberHelper

class Admin::ProductsController < ApplicationController

  def show
    @product = Product.find params[:id]
    @price = number_to_currency(@product.price, options = { delimiter: ","} )
  end
  
  def index
    @products = Product.order(id: :desc).all
    @prices = []
    @products.each  {|item| @prices.push(item.price) }
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
