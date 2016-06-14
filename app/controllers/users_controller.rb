class UsersController < ApplicationController
	
	before_action :authenticate_user!

	def index
		@user = current_user
	end

	def show
		@user = User.find(params[:user_id])
		#@user = current_user
	end
end
