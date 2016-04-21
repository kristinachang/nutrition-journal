class SiteController < ApplicationController
	def index
		@users = current_user
	end

	def about
		render 'about'
	end

	def contact
	end
	
end
