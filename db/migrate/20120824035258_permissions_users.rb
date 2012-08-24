class PermissionsUsers < ActiveRecord::Migration
  def self.up
    create_table :permissions_users, :id => false do |t|
      t.references :permission, :user
    end
  end
 
  def self.down
    drop_table :permissions_users
  end
end
