class Event < ActiveRecord::Base
  has_event_calendar
    attr_accessible :name,:place,:price,:prefecture_id,:detail,:start_at, :end_at, :admin_user
end
