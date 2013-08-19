class RemoveTeachersFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :teachers, :string
    remove_column :users, :study_from, :date
    remove_column :users, :study_to, :date
  end
end