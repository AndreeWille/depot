require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'shows products alphabetically sorted' do
    product_a = Product.create(title: 'ABC', description: 'description for bok ABC', image_url: 'crystal.jpg', price: '0.01')
    product_b = Product.create(title: 'bcd', description: 'description for bok bcd', image_url: 'crystal.jpg', price: '0.01')
    expected_book_order = [product_a, product_b]

    get products_url

    assert expected_book_order == assigns(:products) & expected_book_order
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    title = "The Great Book #{rand(1000)}"
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product), params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @product.title } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product that is not referenced as line item' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test 'should not destroy product that is referenced as line item' do
    assert_no_difference('Product.count') do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end

  test 'cant\'t delete product in cart' do
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end
    assert_redirected_to products_url
  end
end
