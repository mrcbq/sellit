class ProductsController < ApplicationController
  def index
    @products = Product.all.with_attached_photo
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      redirect_to products_path
      flash.notice = t('.created')
    else
      flash.alert = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end

  def update

    if product.update(products_params)
      redirect_to products_path, notice: t('.updated')
    else
      flash.alert = t('.updated-fail')
      render :edit, status: :unprocessable_entity
    end
  end 

  def destroy

    if product.destroy
      redirect_to products_path
      flash.notice = t('.destroyed')
    else
      redirect_to products_path
      flash.alert = t('.destroyed-fail')
      render :new, status: :unprocessable_entity
    end
  end


  private

  def products_params
    params.require(:product).permit(:title, :description, :price, :photo)
  end

  def product
    @product = Product.find(params[:id])
  end
end
