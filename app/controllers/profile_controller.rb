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

  def add_school
    @school = StudyAbroad.new
    render :partial => 'add_school_body'
  end

  def create_school
    @school = StudyAbroad.new(school_params)
    @school.user_id = current_user.id
    is_success = @school.save

    respond_to do |format|
      if is_success
        format.html { render :partial => 'show_body', success: true, notice: '学校情報更新しました' }
      else
        format.html { render :partial => 'add_school_body',success: false, notice: '学校情報更新に失敗しました' }
      end
    end
  end

  def destroy_school

    @school = StudyAbroad.find(params[:id])
    respond_to do |format|
      if @school.destroy
        format.html { redirect_to '/profile/index', success: true, notice: '学校情報削除しました' }
      else
        format.html { redirect_to '/profile/index',success: false, notice: '学校情報削除に失敗しました' }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :image,:study_abroads)
  end

  def school_params
    params.require(:study_abroad).permit(:school_name,:study_from, :study_to, :teacher)
  end

end
