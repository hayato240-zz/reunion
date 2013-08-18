class AddAdminUserToEvent < ActiveRecord::Migration
  def change
    add_column :events, :admin_user, :integer
    add_column :events, :detail, :string
  end
end
