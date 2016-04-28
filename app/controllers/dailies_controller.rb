class DailiesController < ApplicationController

	# before_action :authenticate_user!

	def index
		@user = current_user
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
  		@dailies_by_date = Daily.all(&:date)
	end

	def new
		@user = current_user
		@daily = Daily.new
	end

	def create
		@user = current_user
		@daily = @user.dailies.new(daily_params)
		if @daily.save
			redirect_to user_daily_path(current_user, @daily)
		else
			render 'new'
		end
	end

	def show
		@user = current_user
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@daily = Daily.find(params[:id])
		@dailies_by_date = Daily.all(&:date)
		@item = Item.all

		#need logic here to display items eaten by time and item data.

	end

	def edit
		@user = current_user
		@daily = Daily.find(params[:id])
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
			params.require(:daily).permit(:date, :date_eaten, :mood, :notes, :morning_total, :midday_total, :evening_total, :day_total)
		end
	
end