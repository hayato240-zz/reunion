class Member < ActiveRecord::Base
	attr_accessible :user_id, :event_id, :attend_status
end
