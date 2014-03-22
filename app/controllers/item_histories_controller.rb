class ItemHistoriesController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @item_histories = @item.histories.paginate(page: params[:page])
  end
end
