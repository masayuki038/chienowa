class AddTitleToStars < ActiveRecord::Migration
  def change
    add_column :stars, :title, :string
  end
end
