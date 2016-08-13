class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :current_cart
  before_filter :authorize
  private
	def current_cart
		@cart = Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		@cart = Cart.create
		session[:cart_id] = @cart.id
		@cart
	end

	def current_user
		@user = User.find(session[:user_id])
		@user
	
	end

	protected
		def authorize
			user= User.find_by_id(session[:user_id])
			unless user.admin?
				redirect_to store_path, :notice => "Logged in as User"
	
			end
		end

	 # def require_admin
  #    	unless current_user && current_user.admin?
  #      		flash[:error] = "You are not an admin"
  #      		redirect_to login_path
  #    	end        
  #  	end

end
