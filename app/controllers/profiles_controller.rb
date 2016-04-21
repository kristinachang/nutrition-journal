class ProfilesController < ApplicationController
	def index
		@user=current_user
	end

	def new
	end

	def create
	end

	def show
		@user=current_user
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
