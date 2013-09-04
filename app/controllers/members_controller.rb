class MembersController < ApplicationController
  def index
  end

  def create
  end

  def search
    puts "sssssssssssssssssssssssssssssssss",session[:user_id]
  	@event_users = User.select(:id, :name).where.not(id: session[:user_id]).where("name LIKE ?","%"+params[:q]+"%")
#	render partial: 'members_body'
    p "MEMBER:::::",@event_users
  	if request.xml_http_request?
  		render partial: 'members_body'
  	else
  		respond_to do |format|
  			format.html{ redirect_to root_path, notice: '無効なアクセス'}
  		end
  	end

  end

  def destroy
  end
end
