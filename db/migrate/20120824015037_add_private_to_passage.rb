class AddPrivateToPassage < ActiveRecord::Migration
  def change
    add_column :passages, :private, :boolean
  end
end
