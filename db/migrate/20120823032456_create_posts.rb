class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :passage_id

      t.timestamps
    end
  end
end
