class ChangeStringToText < ActiveRecord::Migration
  def change
    change_column :items, :content, :text, limit: nil
    change_column :item_histories, :content, :text, limit: nil
    change_column :item_histories, :content_diff, :text, limit: nil
  end
end
