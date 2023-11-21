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
    post products_path, params: { product: { title: "Xbox 360", description: "Corre perfecto", price: 340 } 
  }

    assert redirect_to: products_path
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: { product: { description: "Corre perfecto", price: 340 } 
  }

    assert_response :unprocessable_entity
  end
end