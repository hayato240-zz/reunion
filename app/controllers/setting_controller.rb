class SettingController < ApplicationController
	before_filter :authenticate

	def authenticate
	    redirect_to login_index_path unless current_user
	end

end
