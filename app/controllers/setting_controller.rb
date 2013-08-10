class SettingController < ApplicationController
	before_filter :authenticate

	def authenticate
	    redirect_to login_index_path unless current_user
	end

	# GET /settings/edit
	def edit
		@user = current_user
	end
	
	def update_profile
		@user = current_user
		@user.study_from = Date.new(params[:user]['study_from(1i)'].to_i, params[:user]['study_from(2i)'].to_i, params[:user]['study_from(3i)'].to_i)
		@user.study_to = Date.new(params[:user]['study_to(1i)'].to_i, params[:user]['study_to(2i)'].to_i, params[:user]['study_to(3i)'].to_i)
		@user.teachers = params[:teachers] if params[:teachers]
		@user.save
	    redirect_to root_path, notice: "プロフィールを変更しました"
	end
end
