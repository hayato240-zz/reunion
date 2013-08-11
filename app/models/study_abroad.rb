class StudyAbroad < ActiveRecord::Base
	belongs_to :user
	has_many :teachers
end
