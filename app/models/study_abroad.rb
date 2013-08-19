class StudyAbroad < ActiveRecord::Base
	belongs_to :user
	has_many :teachers

	attr_accessible :school_name, :study_from, :study_to, :user_id
end
