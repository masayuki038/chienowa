class CreateItemHistories < ActiveRecord::Migration
  def change
    create_table :item_histories do |t|
      t.integer :item_id
      t.integer :revision
      t.string :title
      t.string :content
      t.string :title_diff
      t.string :content_diff
      t.timestamps
    end
  end
end
