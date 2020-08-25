class CartsController < ApplicationController
  #before_action :user_check, only: %i[edit update]

  def index
    @carts = Cart.where(user: current_user)
  end

  def new
    @product = Product.find(params[:product_id])
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    @user = current_user
    @product = Product.find(params[:product_id])
    @cart.product = @product
    @cart.user = @user
    if @cart.save
      redirect_to carts_path, notice: 'product was successfully added to cart.'
    else
      render :new
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to carts_path, notice: 'product was successfully added to cart.'
    else
      render :edit
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_url, notice: 'product was successfully removed .'
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :user_id, :product_id)
  end

  def user_check
    @user = current_user
    @cart = Cart.find(params[:id])
    redirect_to products_path unless @user == @cart.user_id
  end
end