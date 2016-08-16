class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
  	user = User.authenticate(params[:name], params[:password])
  	if user.present?
  		session[:user_id] = user.id
  		puts "=================================================================="
  		puts current_cart
  		puts "-------------------------------------------------------------------"
  		redirect_to admin_url
  	else
  		redirect_to login_url
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to store_url, :notice => "Logged out"
  end
end
