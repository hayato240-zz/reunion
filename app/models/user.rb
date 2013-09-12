class User < ActiveRecord::Base
  has_many :study_abroads
  attr_accessible :name, :image, :study_abroads_attributes
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/images/event/missing.jpg", :hash_secret => "longSecretString", :url => "/system/images/event/:hash.:extension"
  accepts_nested_attributes_for :study_abroads

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
