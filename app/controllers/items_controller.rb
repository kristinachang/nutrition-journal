class ItemsController < ApplicationController

	# before_action :authenticate_user!

	def index
		@user = current_user
		@daily = Daily.find(params[:daily_id])
		@items = Item.all
	end

	def new
		@user = current_user
		@daily = Daily.find(params[:daily_id])
		@item = Item.new

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
	        @items = JSON.parse(resp.body)["list"]["item"]
	      else 
	        @items = []
	      end
	    end
	    @user = current_user
	    # find the article we are interested in
	    # pass in params[:id] to get :id parameter from request
	    # @ is an instance variable to hold a reference to the entry object
	    @daily = Daily.find(params[:daily_id])
	end

	def create
		@daily=Daily.find(params[:daily_id])
		@item = @daily.items.new(item_params)

		if params[:ndbno].present?
	      resp = Typhoeus.get(
	        "http://api.nal.usda.gov/usda/ndb/reports",
	        params: {
	        format: "json",
	        ndbno: params[:ndbno],
	        type: "b",
	        api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
	        }
	      )
	      @food = JSON.parse(resp.body)["report"]

	      @item = @daily.items.new(item_params)

	      @item.name = @food["food"]["name"]
	      @item.ndbno = params[:ndbno]
	      @item.kcal = @food["food"]["nutrients"][1]["measures"][0]["value"]
	      @item.protein = @food["food"]["nutrients"][2]["measures"][0]["value"]
	      @item.fat = @food["food"]["nutrients"][3]["measures"][0]["value"]
	      @item.carb = @food["food"]["nutrients"][4]["measures"][0]["value"]

	      @item.save
	      
	      redirect_to @entry  
	    end

		if @item.save
			redirect_to user_daily_item_path(current_user, @item.daily, @item)
		else
			render 'new'
		end
	end

	def show
	    # report = params[:q]
	    # if report 
	    #   resp = Typhoeus.get(
	    #     "http://api.nal.usda.gov/usda/ndb/reports",
	    #     params: {
	    #     format: "json",
	    #     ndbno: report,
	    #     type: "b",
	    #     api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
	    #     }
	    #   )
	    #   @food = JSON.parse(resp.body)["report"]
	    # else
	    #   @food = {}
	    # end
	end

	def edit
		@user = current_user
		@daily = Daily.find(params[:daily_id])
		@item = Item.find(params[:id])
	end

	def update
		@user = current_user
		@daily = Daily.find(params[:daily_id])
		@item = @daily.items.new(item_params)

	    # if params[:ndbno].present?
	    #   resp = Typhoeus.get(
	    #     "http://api.nal.usda.gov/usda/ndb/reports",
	    #     params: {
	    #     format: "json",
	    #     ndbno: params[:ndbno],
	    #     type: "b",
	    #     api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
	    #     }
	    #   )
	    #   @food = JSON.parse(resp.body)["report"]

	    #   @item = @daily.items.new(item_params)

	    #   @item.name = @food["food"]["name"]
	    #   @item.ndbno = params[:ndbno]
	    #   @item.kcal = @food["food"]["nutrients"][1]["measures"][0]["value"]
	    #   @item.protein = @food["food"]["nutrients"][2]["measures"][0]["value"]
	    #   @item.fat = @food["food"]["nutrients"][3]["measures"][0]["value"]
	    #   @item.carb = @food["food"]["nutrients"][4]["measures"][0]["value"]

	    #   @item.save
	      
	    #   redirect_to @entry  
	    # end

	    # unless params[:ndbno].present?
	    #   if @daily.update(daily_params)
	    #     # redirect back to the show page with the way our routes are nested
	    #     # @entry.log can also be params[:log_id]
	    #     redirect_to user_daily_path(current_user, @entry)
	    #   else
	    #     render 'edit'
	    #   end
	    # end
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy

		redirect_to user_daily_path(current_user, @daily)
	end

	private
		def item_params
			params.require(:item).permit(:time, :name, :ndbno, :protein, :fat, :carb, :kcal, :unit, :mood, :notes)
		end
	
end
