class EventsController < ApplicationController
  before_filter :authenticate
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destory]
  skip_before_filter :verify_authenticity_token ,:only=>[:create,:edit]

  # login check
  def authenticate
    redirect_to login_index_path unless current_user
  end
  # GET /events
  # GET /events.json
  def index
    require 'date'
    #.order(:date).
    @events = Event.all.order(:start_at)
  end

  # GET /events/1
  # GET /events/1.json
  def show

  end

  # GET /events/new
  def new
    @event = Event.new
    render :partial => 'form_body'
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    render partial: "form_body"

  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    @event.admin_user = current_user.id

    is_success = @event.save

       Member.create(event_id: @event.id, user_id: session[:user_id], attend_status: 2)
      # パラメータmemberは、distinctionのカンマ区切りで渡される
      members = params[:member2].split(",")


      #グループに参加しているメンバーをDBに保存
      if(members)
        members.each{|user_id|
          user = User.find_by(id: user_id) 
          member = Member.create(:event_id => @event.id, :user_id => user_id, attend_status: 2) if user
        }
      end

    respond_to do |format|
      if is_success
        format.html { render :partial => 'show_form_body', success: true, notice: 'イベントを作成しました' }
        format.json { render action: 'index', status: :created}
      else
        format.html { render :partial => 'form_body',success: false, notice: 'イベントに失敗しました' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
#        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.html { render :partial => 'show_form_body', success: true, notice: 'イベントの更新に成功しました'}
        format.json { head :no_content }

      else
        format.html { render :partial => 'form_body', success: false, notice: 'イベントの更新に失敗しました' }
        format.json { render json: @event.errors, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:image,:name, :date, :place, :price, :detail, :prefecture_id, :start_at, :end_at)
    end

    #イベントの作成者以外は、編集削除が出来ないようにする
    def check_user
      if Event.find(params[:id]).admin_user != current_user.id
        redirect_to root_path
      end
    end
end
