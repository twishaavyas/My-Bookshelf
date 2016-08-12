class OrdersController < ApplicationController
	
	skip_before_filter :authorize, :only => [:new, :create]
	protect_from_forgery with: :exception
	def show
		@order = Order.find(params[:id])
	end

	def edit
		@order = Order.find(params[:id])
	end

	def index
		@orders = Order.all
	end

	def new
		if current_cart.line_items.empty?
			redirect_to store_url, :notice => "Your cart is empty"
			return
		end
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		@order.add_line_items_from_cart(current_cart)
		if @order.save
			Cart.destroy(session[:cart_id])
			session[:cart_id] = nil
			#NotifierMailer.order_received(@order).deliver
			redirect_to @order
		else
			render 'new'
		end
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
			redirect_to @order
		else
			render 'edit'
		end
	end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy
		redirect_to orders_path
	end

	private
		def order_params
			params.require(:order).permit(:name, :address, :email, :pay_type)
		end




end
