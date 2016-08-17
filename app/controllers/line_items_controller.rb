class LineItemsController < ApplicationController
	skip_before_filter :authorize, :only => [:create, :destroy, :update, :increase_item, :decrease_item]
	def show
		@line_item = Line_item.find(params[:id])
	end

	def edit
		@line_item = Line_item.find(params[:id])
	end

	def index
		@line_items = Line_item.all
	end

	def new
		@line_item = Line_item.new
	end

	def create
		@cart = current_cart

		product = Product.find(params[:product_id])
		@line_item = @cart.add_product(product.id)
		respond_to do |format|
			if @line_item.save
				format.html { redirect_to(store_url) }
				format.js 
				format.xml { render :xml => @line_item,
				:status => :created, :location => @line_item }
			else	
				format.html { render :action => "new" }
				format.xml { render :xml => @line_item.errors,
				:status => :unprocessable_entity }
			end
		end
	end

	def update
		@line_item = Line_item.find(params[:id])
		if @line_item.update(line_item_params)
			redirect_to @line_item
		else
			render 'edit'
		end
	end

	def increase_item
		@line_item = LineItem.find(params[:id])
		@line_item.quantity += 1
		@line_item.save
		redirect_to store_path
	end

	def decrease_item
		@line_item = LineItem.find(params[:id])
		if @line_item.quantity > 1
			@line_item.quantity -= 1
		else
			@line_item.destroy
		end
		@line_item.save
		redirect_to store_path
	end

	def destroy
		@line_item = LineItem.find(params[:id])
		@line_item.destroy
		redirect_to store_path
	end
	

	private
		def line_item_params
			params.require(:line_item).permit(:product_id, :cart_id)
		end

	# private
	# 	def current_line_item
	# 		line_item.find(session[:line_item_id])
	# 		rescue ActiveRecord::RecordNotFound
	# 		line_item = line_item.create
	# 		session[:line_item_id] = line_item.id
	# 		line_item
	# 	end


end
