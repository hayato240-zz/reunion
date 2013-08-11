# -*- coding: utf-8 -*-
class SessionsController < ApplicationController

  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])

    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "ログインしました"
    else
      User.create_with_omniauth(auth)
      redirect_to root_url, :notice => "#{auth["info"]["name"]}さんの#{auth["provider"]}と接続しました"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Log out"
  end
end
