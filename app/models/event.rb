class Event < ActiveRecord::Base
  attr_accessible :image,:name,:date,:place,:price,:prefecture_id,:detail
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/images/event/missing.jpg", :hash_secret => "longSecretString", :url => "/system/images/event/:hash.:extension"

  validates :name,  :presence => {:message =>'イベント名は必須です。'}

end
