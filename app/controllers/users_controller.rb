class UsersController < ApplicationController
	protect_from_forgery with: :exception
	skip_before_filter :authorize 

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def index
		@users = User.order(:name)
	end

	def new
		@user = User.new
	end

	# def create
	# 	@user = User.new(user_params)
	# 	if @user.save
	# 		redirect_to @user
	# 	else
	# 		render 'new'
	# 	end
	# end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html { redirect_to(store_url,
				:notice => "User #{@user.name} was successfully created.") }
				format.xml { render :xml => @user,
				:status => :created, :location => @user }
			else
				format.html { render :action => "new" }
				format.xml { render :xml => @user.errors,
				:status => :unprocessable_entity }
			end
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		begin
			@user.destroy
			flash[:notice] = "User #{@user.name} deleted"
		    redirect_to users_path
		end
	end

	private
		def user_params
			params.require(:user).permit(:name ,:password,:password_confirmation, :email)
		end

end
