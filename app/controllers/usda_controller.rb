class UsdaController < ApplicationController
	def search
	  resp = Typhoeus.get(
      "http://api.nal.usda.gov/usda/ndb/search",
      params: {
      format: "json",
      q: params[:q],
      sort: "n",
      max: 100,
      offset: 0,
      api_key: "bT0Q1R0Js9aaOsjTR9ro6Oax1y21Wg2J8fmr74Vc"
      }
    )

    @foods = JSON.parse(resp.body)["list"]["item"]
	
		respond_to do |format|
			format.json {
				render json: @foods
			}
			format.js
		end
	end
end
