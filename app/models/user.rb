class User < ActiveRecord::Base
  has_many :study_abroads

  #初回ログインの際に、ユーザ情報をDBに保存
  def self.create_with_omniauth(auth)
    create!do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.image = auth["info"]["image"]

      if user.provider == "facebook"
         user.name = auth["info"]["name"]
      else
         user.name = auth["info"]["nickname"]
      end
    end
  end
end
