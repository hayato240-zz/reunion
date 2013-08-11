class AddStudyAbroadIdToTeacher < ActiveRecord::Migration
  def change
    add_reference :teachers, :study_abroads, index: true
  end
end
