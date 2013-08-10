class AddTeachersToUser < ActiveRecord::Migration
  def change
    add_column :users, :teachers, :string
    add_column :users, :study_from, :date
    add_column :users, :study_to, :date
  end
end
