class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :update, :destroy]

  def show
    @item = Item.find(params[:id])
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
      redirect_to user_path(current_user.id)
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated"
      redirect_to user_path(current_user.id)
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

  def home
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
