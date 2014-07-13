class WelcomeController < ApplicationController
  def index
    # if enter url like http://localhost:3000/tags/motivation then filter
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
      authorize @posts
    else
      @posts = Post.all
      authorize @posts
    end
  end

  def about
  end

end
