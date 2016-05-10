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

	 #    Add the following when implementing search function on /new.
	 #    if params[:q]
	 #      search = params[:q]
	 #      if search
	 #        resp = Typhoeus.get(
	 #          "http://api.nal.usda.gov/usda/ndb/search",
	 #          params: {
	 #          format: "json",
	 #          q: search,
	 #          sort: "n",
	 #          max: 30,
	 #          offset: 0,
	 #          api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
	 #          }
	 #        )
	 #        @foods = JSON.parse(resp.body)["list"]["item"]
	 #      else 
	 #        @foods = []
	 #      end
	 #    end		
	end

	def create
		@daily=Daily.find(params[:daily_id])
		@item = @daily.items.new(item_params)

	 #    Add the following when implementing search function on /new.
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

	 #      # @item = @daily.items.new (this line would create a new item instead of updating the current one)

	 #      @item.name = @food["food"]["name"]
	 #      @item.ndbno = params[:ndbno]
	 #      @item.kcal = @food["food"]["nutrients"][1]["measures"][0]["value"]
	 #      @item.protein = @food["food"]["nutrients"][2]["measures"][0]["value"]
	 #      @item.fat = @food["food"]["nutrients"][3]["measures"][0]["value"]
	 #      @item.carb = @food["food"]["nutrients"][4]["measures"][0]["value"]

	 #      @item.save
	      
	 #      redirect_to user_daily_item_path(current_user, @daily, @item)
	 #    end

		if @item.save
			redirect_to user_daily_item_path(current_user, @daily, @item)
		else
			render 'new'
		end
	end

	def show
		@user = current_user
	    @daily = Daily.find(params[:daily_id])
	    @item = Item.find(params[:id])

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
	        @foods = JSON.parse(resp.body)["list"]["item"]
	      else 
	        @foods = []
	      end
	    end
	end

	def edit
		@user = current_user
		@daily = Daily.find(params[:daily_id])
		@item = Item.find(params[:id])
	end

	def update
		@user = current_user
		@daily = Daily.find(params[:daily_id])
		@item = Item.find(params[:id])

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

	      # @item = @daily.items.new (this line would create a new item instead of updating the current one)

	      @item.name = @food["food"]["name"]
	      @item.ndbno = params[:ndbno]
	      @item.kcal = @food["food"]["nutrients"][1]["measures"][0]["value"]
	      @item.protein = @food["food"]["nutrients"][2]["measures"][0]["value"]
	      @item.fat = @food["food"]["nutrients"][3]["measures"][0]["value"]
	      @item.carb = @food["food"]["nutrients"][4]["measures"][0]["value"]

	      @item.save
	      
	      redirect_to user_daily_item_path(current_user, @daily, @item)
	    end

	    unless params[:ndbno].present?
	      if @item.update(item_params)
	        redirect_to user_daily_item_path(current_user, @daily, @item)
	      else
	        render 'edit'
	      end
	    end
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy

		redirect_to user_dailies_path(current_user, @daily)
	end

	private
		def item_params
			params.require(:item).permit(:time, :name, :mood, :notes)
		end
	
end
