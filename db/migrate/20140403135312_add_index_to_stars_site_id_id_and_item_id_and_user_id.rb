class AddIndexToStarsSiteIdIdAndItemIdAndUserId < ActiveRecord::Migration
  def change
    add_index :stars, [:site_id, :item_id, :user_id], unique: true
  end
end
