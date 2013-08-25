class AddPlaceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :place, :string
    add_column :events, :price, :integer
    add_column :events, :is_public, :boolean
    add_column :events, :prefecture_id, :integer
    add_column :events, :detail, :string
    add_column :events, :admin_user, :integer
  end
end
