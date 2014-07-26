class FollowedpostsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    followedpost = current_user.followedposts.build(post: @post)
    authorize followedpost

    if followedpost.save 
      flash[:notice] = "You have followed this post. You will be notified via email when a new SumPoint is added."
      redirect_to @post
    else
      flash[:error] = "Unable to follow post. Please try again."
      redirect to @post
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    followedpost = current_user.followedposts.find(params[:id])
    authorize followedpost

    if followedpost.destroy
      redirect_to @post
    else
      flash[:error] = "Unable to unfollow. Please try again."
      redirect_to @post
    end
  end


end
