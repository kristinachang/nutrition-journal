class ItemsController < ApplicationController

	before_action :authenticate_user!

	def index
		@daily=Daily.find(params[:daily_id])
	end

	def new
		@item=Item.new
		@daily=Daily.find(params[:daily_id])
	end

	def create
		@daily=Daily.find(params[:daily_id])
		@item=@daily.items.new(item_params)

		if @item.save
			redirect_to user_daily_item_path(current_user, @item.daily, @item)
		else
			render 'new'
		end
	end

	def show
    if params[:q]
      search = params[:q]
      if search
        resp = Typhoeus.get(
          "http://api.nal.usda.gov/usda/ndb/search",
          params: {
          format: "json",
          q: search,
          sort: "n",
          max: 30,
          offset: 0,
          api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
          }
        )
        @item = JSON.parse(resp.body)["list"]["item"]
      else 
        @items = []
      end
    end
    @user = current_user
    # find the article we are interested in
    # pass in params[:id] to get :id parameter from request
    # @ is an instance variable to hold a reference to the entry object
    @item = Item.find(params[:id])
	end

	def edit
		@item=Item.find(params[:id])
		@daily=Daily.find(params[:daily_id])
	end

	# def update
	# 	@entry = Entry.find(params[:id])

 #    if params[:ndbno].present?
 #      resp = Typhoeus.get(
 #        "http://api.nal.usda.gov/usda/ndb/reports",
 #        params: {
 #        format: "json",
 #        ndbno: params[:ndbno],
 #        type: "b",
 #        api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
 #        }
 #      )
 #      @food = JSON.parse(resp.body)["report"]

 #      @report = @entry.reports.new

 #      @report.name = @food["food"]["name"]
 #      @report.ndbno = params[:ndbno]
 #      @report.kcal = @food["food"]["nutrients"][1]["measures"][0]["value"]
 #      @report.protein = @food["food"]["nutrients"][2]["measures"][0]["value"]
 #      @report.fat = @food["food"]["nutrients"][3]["measures"][0]["value"]
 #      @report.carb = @food["food"]["nutrients"][4]["measures"][0]["value"]

 #      @report.save
      
 #      redirect_to @entry  
 #    end

 #    unless params[:ndbno].present?
 #      if @entry.update(entry_params)
 #        # redirect back to the show page with the way our routes are nested
 #        # @entry.log can also be params[:log_id]
 #        redirect_to user_log_entry_path(current_user, @entry.log, @entry)
 #      else
 #        render 'edit'
 #      end
 #    end
	# end

	def destroy
		@item=Item.find(params[:id])
		@item.destroy

		redirect_to user_daily_path(current_user, @item.daily)
	end

	private
		def item_params
			params.require(:item).permit(:date, :time, :datetime, :name, :mood, :notes)
		end
	
end
