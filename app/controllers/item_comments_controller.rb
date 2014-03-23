class ItemCommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create]

  def create
    @item_comment = ItemComment.new(item_comment_params)
    item = Item.find(@item_comment.item_id)
    @item_comment.user = current_user
    @item_comment.item = item
    if @item_comment.save
      flash[:success] = "Comment added"
      redirect_to item_path(item)
    else
      render 'show'
    end
  end
private
  def item_comment_params
    params.require(:item_comment).permit(:content, :item_id)
  end
end
