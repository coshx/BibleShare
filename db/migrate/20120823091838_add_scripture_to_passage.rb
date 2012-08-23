class AddScriptureToPassage < ActiveRecord::Migration
  def change
    add_column :passages, :scripture, :text
  end
end
