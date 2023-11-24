class ProductsController < ApplicationController
  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_photo.order(created_at: :desc).load_async
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end
    if params[:query_text].present?
      @products = @products.search_full_text(params[:query_text])
    end
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
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end

  def product
    @product = Product.find(params[:id])
  end
end
