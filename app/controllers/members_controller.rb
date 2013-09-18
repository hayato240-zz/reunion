class MembersController < ApplicationController
  def index
  end

  def join
    @member = Member.where(:event_id => params[:event_id], :user_id => session[:user_id]).last

    if @member
      is_success = @member.update(:attend_status => params[:attend_status])
    else
      @member = Member.new(:event_id => params[:event_id], :user_id => session[:user_id],:attend_status => params[:attend_status])
      is_success = @member.save
    end
    @event = Event.find(params[:event_id])   
    respond_to do |format|
      if is_success
        format.html { render :partial => 'show_attend_member_body', success: true, notice: 'イベントの更新に成功しました'}
        format.json { head :no_content }

      else
         format.html { render :partial => 'show_attend_member_body',  success: false, notice: 'イベントの更新に失敗しました' }
         format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end

  def create
    @member = Member.new(:event_id => params[:event_id], :user_id => session[:user_id],:attend_status => params[:attend_status])
    @event = Event.find(params[:event_id])   
    p "memberCREATE:"
    respond_to do |format|
      if @member.save
#        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.html { render :partial => 'show_attend_member_body', success: true, notice: 'イベントの更新に成功しました'}
#        format.html { render "events/show"}
        format.json { head :no_content }

      else
         format.html { render :partial => 'show_attend_member_body',  success: false, notice: 'イベントの更新に失敗しました' }
#        format.html { render "events/show"  , success: false, notice: 'イベントの更新に失敗しました' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_member
#    @member = Member.find(params[:member_id])
    @member = Member.where(:event_id => params[:event_id], :user_id => session[:user_id]).last
    p "memberUP:", @member
    @event = Event.find(params[:event_id])
    is_success = @member.update(:attend_status => params[:attend_status])

    respond_to do |format|
      if is_success
        format.html { render :partial => 'show_attend_member_body', success: true, notice: 'イベントの更新に成功しました'}
#        format.html { render "events/show", success: true, notice: 'イベントの更新に成功しました'}
        format.json { head :no_content }

      else
        format.html { render :partial => 'show_attend_member_body', success: false, notice: 'イベントの更新に失敗しました' }
#        format.html {render "events/show", success: false, notice: 'イベントの更新に失敗しました' }
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
