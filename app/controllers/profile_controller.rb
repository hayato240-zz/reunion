class ProfileController < ApplicationController
  before_filter :authenticate

  def authenticate
      redirect_to login_index_path unless current_user
  end
  
  def index
    @user = current_user
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
