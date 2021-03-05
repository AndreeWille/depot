# frozen_string_literal: true

# CRUD Controller that manages Carts
class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show; end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit; end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    set_cart
    respond_to do |format|
      format.html { redirect_to store_index_url, notice: 'Your cart is currently empty.' }
      format.js
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def cart_params
    params.fetch(:cart, {})
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_index_url, notice: 'Invalid cart'
  end
end
