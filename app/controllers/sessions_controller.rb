# -*- coding: utf-8 -*-
class SessionsController < ApplicationController

  #facebookでのログインした時に呼ばれるメソッド
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])

    #以前にログインした事がある場合
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "ログインしました"

    #初めてログインする場合
    #ユーザ情報をDBに保存
    else
      User.create_with_omniauth(auth)
      user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "#{auth["info"]["name"]}さんの#{auth["provider"]}と接続しました"
    end
  end

  #ログアウト用メソッド
  #GET logout_path
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Log out"
  end
end
