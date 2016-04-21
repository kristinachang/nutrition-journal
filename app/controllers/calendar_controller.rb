class CalendarController < ApplicationController
  def show
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  	@dailies_by_date = Daily.all(&:date)
  end
end
