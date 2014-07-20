class SumpointsController < ApplicationController


  # shows Sumpoints by date of creation
  def index
    @sumpoints = Sumpoint.all
  end

  def new
    @post = Post.find(params[:post_id])
    # Only want to show the sumpoints that belong to user
    @sumpoint = Sumpoint.new
    authorize @sumpoint
  end

  def create
    @post = Post.find(params[:id])
    @sumpoint = current_user.sumpoints.build[:body, :post_id]
    @sumpoint.post = @post

    authorize @sumpoint
    if @sumpoint.save
      flash[:notice] = "SumPoint was saved successfully."
      redirect_to @post
    else
      flash[:error] = "Error saving SumPoint. Please try again."
      render :new
    end
  end

  private

  def sumpoint_params
    params.require(:sumpoint).permit(:body, :post_id, :user_id)
  end


end
