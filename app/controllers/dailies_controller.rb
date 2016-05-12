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
		@items = Item.all

		#need logic here to display items eaten by time and item data.
		@kcal = 0
		@protein = 0
		@carb = 0 
		@fat =0

		@morning_total = []
		@midday_total = []
		@evening_total = []
		@day_total = []

		@items.each do |item|
			if (item.date == @daily.date)
				if (item.time.strftime("%H:%M").between?("00:00","11:30"))
					@morning_total << {'time': item.time.strftime("%H:%M"), 'name': item.name, 'kcal': item.kcal, 'protein': item.protein, 'carb': item.carb, 'fat': item.fat}
					#puts item.time
				elsif (item.time.strftime("%H:%M").between?("11:31","17:30"))
					@midday_total << {'time': item.time.strftime("%H:%M"), 'name': item.name, 'kcal': item.kcal, 'protein': item.protein, 'carb': item.carb, 'fat': item.fat}
					#puts item.time
				else (item.time.strftime("%H:%M").between?("17:31","23.59"))
					@evening_total << {'time': item.time.strftime("%H:%M"), 'name': item.name, 'kcal': item.kcal, 'protein': item.protein, 'carb': item.carb, 'fat': item.fat}
				end
				@day_total << {'kcal': item.kcal, 'protein': item.protein, 'carb': item.carb, 'fat': item.fat}
				@kcal += item.kcal.to_f
				@protein += item.protein.to_f
				@carb += item.carb.to_f
				@fat += item.fat.to_f
			end
		end
		#puts @morning_total
		#puts @midday_total
		#puts @evening_total
		#puts @day_total
		#puts @kcal

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