class UsersController < ApplicationController
 before_action :authenticate_user!

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path(current_user)
    else
      render "devise/registrations/edit"
    end
  end

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        current_user.save
        sign_in(current_user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  # Function provides all liked Sumpoints of a user
  def my_likes
    @liked_sumpoints = []
    @likes = Like.where(user_id: current_user, value: 1)
    @likes.each do |like|
      @liked_sumpoints << like.sumpoint 
    end
  end

  # Function provides all posts a user is following
  def my_follows
    @followed_posts = []
    @follows = Followedpost.where(user_id: current_user)
    @follows.each do |follow|
      @followed_posts << follow.post
    end
  end

  def library
    # get all likes
    @liked_sumpoints = []
    @likes = Like.where(user_id: current_user, value: 1)
    
    # get all sumpoints from the likes data
    @likes.each do |like|
      @liked_sumpoints << like.sumpoint
    end

    # get all tags from the liked_sumpoints
    @all_tags = []
    @liked_sumpoints.each do |sumpoint|
      sumpoint.tags.each do |tag|
        @all_tags << tag
      end
    end
    # remove duplicates from array of tags
    @all_tags.uniq!
    # sort tags by their name, but sort when they are downcased! otherwise might not sort 
    # properly
    @all_tags.sort_by! { |t| t.name.downcase }

  end

 private

  # -- for the omniauth tutorial
  # def user_params
  #   accessible = [:name, :email] # extend with your own params
  #   #accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
  #   params.require(:user).permit(:name, :email)
  # end

  # old def user_params
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end