require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 2
  end
  
  test 'render a detail product page' do
    get product_path(products(:ps4))

    assert_response :success
    assert_select '.title', 'PS4 Fat'
    assert_select '.description', 'PS4 en buen estado'
    assert_select '.price', '150$'
  end

  test 'render a new product form page' do
    get new_product_path

    assert_response :success
    assert_select '.new_product'
  end

  test 'allow to create a new product' do
    post products_path, params: { 
      product: { 
        title: "Xbox 360", 
        description: "Corre perfecto", 
        price: 340 
      } 
  }

    assert redirect_to: products_path
    assert_equal flash[:notice], 'Your product has been created correctly'
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: { product: { description: "Corre perfecto", price: 340 } 
  }

    assert_response :unprocessable_entity
  end

  test 'render a edit product form' do
    get edit_product_path(products(:ps4))

    assert_response :success
    assert_select 'form'
  end

  test 'allow to update a product' do
    patch product_path(products(:ps4)), params: { 
      product: { 
        price: 165 
      } 
  }

    assert redirect_to: products_path
    assert_equal flash[:notice], 'Your product has been updated correctly'
  end

  test 'does not allow to update a product' do
    patch product_path(products(:ps4)), params: { 
      product: { 
        price: nil 
      } 
  }

    assert_response :unprocessable_entity
    assert redirect_to: product_path
    assert_equal flash[:alert], 'Occur some error while update your product'
  end

  test 'can delete products' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Your product has been deleted correctly'
  end
end