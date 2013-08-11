class AddUserIdToStudyAbroad < ActiveRecord::Migration
  def change
    add_reference :study_abroads, :user, index: true
  end
end
