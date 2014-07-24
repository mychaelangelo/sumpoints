class LikesController < ApplicationController
  before_action :load_sumpoint_and_like

  def create
    update_like(1)
    redirect_to :back
  end

  def destroy
    update_like(-1) 
    redirect_to :back
  end 


  private

  # Grab the sumpoint object, then seek out 'like' for current user if he already made one
  def load_sumpoint_and_like
    @sumpoint = Sumpoint.find(params[:sumpoint_id])
    @like = @sumpoint.likes.where(user_id: current_user.id).first
  end

  # Update the like with new value or if non-existant like create one and save it to DB
  def update_like(new_value)
    if @like # update it
      authorize @like, :update? # only members can update the likes on sumpoints
      @like.value = new_value
      @like.save!
    else # create new like
      @like = current_user.likes.build(value: new_value, sumpoint: @sumpoint)
      authorize @like, :create? # only members can like sumpoints
      @like.save!
    end
  end



end
