class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
      t.string :title
      t.string :bible
      t.string :content

      t.timestamps
    end
  end
end
