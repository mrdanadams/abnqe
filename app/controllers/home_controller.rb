class HomeController < ApplicationController
	def index
		# TODO use a different layout if not logged in

		render 'member_index' if user_signed_in?
	end
end
