class AddCommentToStars < ActiveRecord::Migration
  def change
    add_column :stars, :comment, :text
  end
end
