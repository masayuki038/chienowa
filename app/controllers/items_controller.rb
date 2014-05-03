class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :update, :destroy, :home]

  def show
    @item = Item.find(params[:id])
    @item_comment = ItemComment.new(item: @item)
    render layout: "with_user_items"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      flash[:success] = "Item saved"
      #redirect_to controller: 'users', action: 'show', params: { id: current_user.id }
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated"
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:success] = "Item destroyed"
    redirect_to user_path(current_user.id)
  end

  def search
    @items = Item.where("title LIKE ? or content LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").paginate(page: params[:page])
  end

  def home
    redirect_to user_path(current_user.id)
  end

  def preview
    render text: markdown(params[:content]).to_s, layout: false
  end

  def help
  end

  def contact
  end

private
  def item_params
    params.require(:item).permit(:title, :content)
  end
end
