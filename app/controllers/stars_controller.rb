class StarsController < ApplicationController
  def create
    @star = Star.new(star_params)
    @star.user = current_user
    if @star.save
      render :nothing => true, status: 201
    else
      render :nothing => true, status: 500
    end
  end

  def update
    star = Star.find(:first, conditions:
      { site_id: params[:site_id], item_id: params[:item_id], user_id: current_user.id })
    star.comment = params[:comment]
    if star.save
      render :nothing => true, status: 200
    else
      render :nothing => true, status: 500
    end
  end

  def destroy
    star = Star.find(:first, conditions:
      { site_id: params[:site_id], item_id: params[:item_id], user_id: current_user.id })
    star.destroy
    render :nothing => true, status: 200
  end

  def list
    @stars = Star.find(:all,
      conditions: { site_id: params[:site_id], item_id: params[:item_id] })
    render :layout => false
  end

private
  def star_params
    params.require(:star).permit(:site_id, :item_id, :url, :comment)
  end
end
