class AddEventIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :event_id, :integer
  end
end
