# frozen_string_literal: true

require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test 'should get index' do
    get carts_url
    assert_response :success
  end

  test 'should get new' do
    get new_cart_url
    assert_response :success
  end

  test 'should create cart' do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {} }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test 'should show cart' do
    get cart_url(@cart)
    assert_response :success
  end

  test 'should get edit' do
    get edit_cart_url(@cart)
    assert_response :success
  end

  test 'should destroy cart' do
    cart_id_increment = 1

    post line_items_url, params: { product_id: products(:ruby).id }, xhr: true
    old_cart_id = Cart.find(session[:cart_id]).id

    delete cart_url(@cart)

    new_cart_id = Cart.find(session[:cart_id]).id

    assert new_cart_id == old_cart_id + cart_id_increment
  end
end
