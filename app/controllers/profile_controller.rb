class ProfileController < ApplicationController
skip_before_filter :verify_authenticity_token

  def authenticate
      redirect_to login_index_path unless current_user
  end
  
  def index
    @user = current_user
  end

  def edit
    @user = current_user
    render :partial => 'edit_body'
  end

  def create
  end

  def update
    @user = current_user
    is_success = @user.update(params[:user])

#    render :partial => 'show_body'

    respond_to do |format|
      if is_success
        format.html { render :partial => 'show_body', success: true, notice: 'イベントを作成しました' }
      else
        format.html { render :partial => 'edit_body',success: false, notice: 'イベントに失敗しました' }
      end
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :image,:study_abroads)
  end

end
