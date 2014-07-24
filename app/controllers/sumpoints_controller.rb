class SumpointsController < ApplicationController

  # shows Sumpoints by date of creation
  def index
    @sumpoints = Sumpoint.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = Post.find(params[:post_id])
    @sumpoint = Sumpoint.new
    authorize @sumpoint
  end

  def create
    @post = Post.find(params[:post_id])
    @sumpoint = current_user.sumpoints.build(sumpoint_params)
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
    params.require(:sumpoint).permit(:body, :tag_list)
  end


end
