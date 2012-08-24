class AddIsPrivateToPassage < ActiveRecord::Migration
  def change
    add_column :passages, :is_private, :boolean
  end
end
