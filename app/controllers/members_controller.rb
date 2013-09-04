class MembersController < ApplicationController
  def index
  end

  def create
  end

  def add_member
    @member = Member.where(event_id: params[:event_id]).last
#    @member = Member.where(user_id: session[:user_id], event_id: params[:event_id]).last
#    is_success = @member.update_attribute(:attend_status => 0) 
#     @member.update_attiribute(:attend_status => params[:attend_status])
    p "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",params[:attend_status]
    respond_to do |format|
      if @member.update(:attend_status => params[:attend_status])
#        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.html { render :partial => 'show_form_body', success: true, notice: 'イベントの更新に成功しました'}
        format.json { head :no_content }

      else
        format.html { render :partial => 'form_body', success: false, notice: 'イベントの更新に失敗しました' }
        format.json { render json: @event.errors, status: :unprocessable_entity }

      end
    end

  end

  def search

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
