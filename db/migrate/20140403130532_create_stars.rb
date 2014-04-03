class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :user_id
      t.string :site_id
      t.string :item_id
      t.text :url

      t.timestamps
    end
  end
end
