class Event < ActiveRecord::Base
  has_event_calendar
    attr_accessible :name,:place,:price,:prefecture_id,:detail,:start_at, :end_at, :admin_user, :image
    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/images/event/missing.jpg", :hash_secret => "longSecretString", :url => "/system/images/event/:hash.:extension"

	validates :name, :presence => {:message =>'イベント名は必須です。'}
end
