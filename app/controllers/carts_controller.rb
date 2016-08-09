class CartsController < ApplicationController
	protect_from_forgery with: :exception
	def show
		@cart = Cart.find(params[:id])
	end

	def edit
		@cart = Cart.find(params[:id])
	end

	def index
		@carts = Cart.all
	end

	def new
		@cart = Cart.new
	end

	def create
		@cart = Cart.new(cart_params)
		if @cart.save
			redirect_to @cart
		else
			render 'new'
		end
	end

	def update
		@cart = Cart.find(params[:id])
		if @cart.update(cart_params)
			redirect_to @cart
		else
			render 'edit'
		end
	end

	def destroy
		@cart = Cart.find(params[:id])
		@cart.destroy
		redirect_to carts_path
	end

	private
		def cart_params
			params.require(:cart)
		end

	# private
	# 	def current_cart
	# 		Cart.find(session[:cart_id])
	# 		rescue ActiveRecord::RecordNotFound
	# 		cart = Cart.create
	# 		session[:cart_id] = cart.id
	# 		cart
	# 	end




end
