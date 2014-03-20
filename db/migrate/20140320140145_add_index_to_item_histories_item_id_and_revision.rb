class AddIndexToItemHistoriesItemIdAndRevision < ActiveRecord::Migration
  def change
    add_index :item_histories, [:item_id, :revision], unique: true
  end
end
