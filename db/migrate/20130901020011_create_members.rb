class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :attend_status

      t.timestamps
    end
  end
end
