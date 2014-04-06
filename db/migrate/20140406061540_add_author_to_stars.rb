class AddAuthorToStars < ActiveRecord::Migration
  def change
    add_column :stars, :author, :string
  end
end
