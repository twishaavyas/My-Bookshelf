class OrdersController < ApplicationController
	
	skip_before_filter :authorize, :only => [:new, :create, :destroy, :previous_orders]
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

	def previous_orders
		user = User.find(params[:id])
		if !(user == current_user)
			redirect_to store_path
		else
			@orders = current_user.orders.all
		end
	end

	def new
		if current_cart.line_items.empty?
			redirect_to store_url, :notice => "Your cart is empty"
			return
		end
		@order = current_user.orders.new
	end

	def create
		puts order_params
		@order = current_user.orders.new(order_params)
		puts @order
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
		puts params
		@order = Order.find(params[:id])
		puts @order
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
