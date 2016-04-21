class DailiesController < ApplicationController
	def index
		@daily=Daily.new
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
  		@dailies_by_date = Daily.all(&:date)
	end

	def new
	end

	def create
		@daily=current_user.dailies.new(daily_params)
		if @daily.save
			redirect_to user_daily_path(current_user, @daily)
		else
			render 'new'
		end
	end

	def show
		@daily=Daily.find(params[:id])
		@item=Item.all
	end

	def edit
		@daily=Daily.find(params[:id])
	end

	def update
	end

	def destroy
		@daily=Daily.find(params[:id])
		@daily.destroy
			redirect_to user_dailies_path(current_user)
	end


	private
		def daily_params
			params.require(:daily).permit(:date)
		end
	
end
