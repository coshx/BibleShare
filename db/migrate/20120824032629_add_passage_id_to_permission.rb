class AddPassageIdToPermission < ActiveRecord::Migration
  def change
    add_column :permissions, :passage_id, :integer
  end
end
