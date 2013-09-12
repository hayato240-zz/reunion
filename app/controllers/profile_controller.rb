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
    @user.update(user_params)



    render :partial => 'show_body'
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :image)
  end
  def study_abroads_params
    params.require(:study_abroads_attributes).permit(:school_name, :study_from,:study_to,:user_id)
  end

end
