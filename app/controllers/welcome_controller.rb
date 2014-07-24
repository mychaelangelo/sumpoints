class WelcomeController < ApplicationController
  def index
    # if enter url like http://localhost:3000/tags/motivation then filter
    if params[:tag]
      #@posts = Post.tagged_with(params[:tag]) 
      @sumpoints = Sumpoint.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
      authorize @sumpoints
    else
      @sumpoints = Sumpoint.paginate(page: params[:page], per_page: 10)
      authorize @sumpoints
    end
  end

  def about
  end

end
