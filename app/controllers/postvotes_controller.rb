class PostvotesController < ApplicationController
  before_filter :setup

  def up_postvote
    update_postvote(1)
    redirect_to @post
  end

  def down_postvote
    update_postvote(-1)
    redirect_to @post
  end

  private
  # private methods below

  def setup
    # Grab post
    @post = Post.find(params[:post_id])
    # Look for existing vote by current user, so don't create multiple votes
    @postvote = @post.postvotes.where(user_id: current_user.id).first
  end

  def update_postvote(new_value)
    if @postvote # if already voted, update it
      authorize @postvote, :update?
      @postvote.update_attribute(:value, new_value)
    else # create new vote
      @postvote = current_user.postvotes.build(value: new_value, post: @post)
      authorize @postvote, :create?
      @postvote.save
    end
  end


end