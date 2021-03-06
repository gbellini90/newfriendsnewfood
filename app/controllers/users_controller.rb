class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)

		if @user.valid?
			session[:user_id] = @user.id
			redirect_to @user
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to new_user_path
		end
	end

	def update
		@user.update(user_params)

		if @user.valid?
			redirect_to @user
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to edit_user_path
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		redirect_to users_path
	end

	def login
		@user = User.new
	end

	def logging
		puts "logging in"
		@user = User.find_by(user_params)
		# byebug
		if @user
			session[:user_id] = @user.id
			redirect_to @user
		else
			flash[:errors] = ["Username or Password is incorrect"]
			redirect_to root_path
		end
	end

	def show
	end

	def edit
		redirect_to @current_user unless @current_user == @user
	end

	private

	def find_user
		# byebug
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :age, :username, :password, :password_confirmation, :img_url, :bio)
	end
end
