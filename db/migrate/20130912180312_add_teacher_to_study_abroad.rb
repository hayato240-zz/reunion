class AddTeacherToStudyAbroad < ActiveRecord::Migration
  def change
    add_column :study_abroads, :teacher, :string
  end
end
