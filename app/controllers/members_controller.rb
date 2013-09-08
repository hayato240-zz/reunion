class MembersController < ApplicationController
  def index
  end

  def create
    @member = Member.new(:event_id => params[:event_id], :user_id => session[:user_id],:attend_status => params[:attend_status])
    @event = Event.find(params[:event_id])   
    debugger
    respond_to do |format|
      if @member.save
        debugger
#        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.html { render :partial => 'events/show_form_body', success: true, notice: 'イベントの更新に成功しました'}
        format.json { head :no_content }

      else
        format.html { render :partial => 'events/show_form_body', success: false, notice: 'イベントの更新に失敗しました' }
        format.json { render json: @event.errors, status: :unprocessable_entity }

      end
    end
  end

  def update_member
#    @member = Member.find(params[:member_id])
    @member = Member.where(event_id: params[:event_id], user_id: session[:user_id]).last
    @event = Event.find(params[:event_id])
    debugger
    is_success = @member.update(:attend_status => params[:attend_status])

    respond_to do |format|
      if is_success
        format.html { render  :partial => 'events/show_form_body', success: true, notice: 'イベントの更新に成功しました'}
        format.json { head :no_content }

      else
        format.html { render :partial => 'events/show_form_body', success: false, notice: 'イベントの更新に失敗しました' }
        format.json { render json: @event.errors, status: :unprocessable_entity }

      end
    end

  end

  def search

  	@event_users = User.select(:id, :name).where.not(id: session[:user_id]).where("name LIKE ?","%"+params[:q]+"%")
#	render partial: 'members_body'
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
