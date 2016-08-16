class CartsController < ApplicationController
	skip_before_filter :authorize, :only => [:create, :update, :destroy]
	protect_from_forgery with: :exception
	# GET /carts/1
	# GET /carts/1.xml
	def show
		begin
			@cart = Cart.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			logger.error "Attempt to access invalid cart #{params[:id]}"
			redirect_to store_url, :notice => 'Invalid cart'
		else
			respond_to do |format|
				format.html # show.html.erb
				format.xml { render :xml => @cart }
			end
		end
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
		session[:cart_id] = nil
		respond_to do |format|
			format.html { redirect_to(store_url,
				:notice => 'Your cart is currently empty') }
			format.xml { head :ok }
		end
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
