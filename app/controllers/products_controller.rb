class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      redirect_to products_path
      flash.notice = 'Your product has been created correctly'
    else
      flash.alert = 'Please complete all required fields'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(products_params)
      redirect_to products_path, notice: 'Your product has been updated correctly'
    else
      flash.alert = 'Occur some error while update tour product'
      render :edit, status: :unprocessable_entity
    end
  end 
  private

  def products_params
    params.require(:product).permit(:title, :description, :price)
  end
end
