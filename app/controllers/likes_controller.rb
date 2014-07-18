class LikesController < ApplicationController
  before_action :load_sumpoint_and_like

  # see postvotes_controller to see how to include authorization for likes

  def up_like
    update_like(1)
    redirect_to :back
  end

  def down_like
    update_like(-1) 
    redirect_to :back
  end

  private

  def load_sumpoint_and_like
    @sumpoint = Sumpoint.find(params[:sumpoint_id])
    @like = @sumpoint.likes.where(user_id: current_user.id).first
  end

  def update_like(new_value)
    if @like # update it
      authorize @like, :update? # only members can update the likes on sumpoints
      @like.update_attribute(:value, new_value)
    else # create new like
      @like = current_user.likes.build(value: new_value, sumpoint: @sumpoint)
      authorize @like, :create? # only members can like sumpoints
      @like.save
    end
  end






end
