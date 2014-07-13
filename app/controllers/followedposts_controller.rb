class FollowedpostsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    followedpost = current_user.followedposts.build(post: @post)
    authorize followedpost

    if followedpost.save 
      flash[:notice] = "Followed post."
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
      flash[:notice] = "You have unfollowed this post."
      redirect_to @post
    else
      flash[:error] = "Unable to unfollow. Please try again."
      redirect_to @post
    end
  end


end
