class MembersController < ApplicationController
  def index
  end

  def create
  end

  def search
  	@event_users = User.select(:id, :name).where.not(id: current_user.id).where("name LIKE ?","%"+params[:q]+"%")
	render partial: 'members_body'
=begin	
  	if request.xml_http_request?
  		render partial: 'members_body'
  	else
  		respond_to do |format|
  			format.html{ redirect_to root_path, notice: '無効なアクセス'}
  		end
  	end
=end  	
  end

  def destroy
  end
end
