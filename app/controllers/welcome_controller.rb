class WelcomeController < ApplicationController
  def index
    # if enter url like http://localhost:3000/tags/motivation then filter
    if params[:tag]
      #@posts = Post.tagged_with(params[:tag])
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
      authorize @posts
    else
      @posts = Post.paginate(page: params[:page], per_page: 10)
      authorize @posts
    end
  end

  def about
  end

end
