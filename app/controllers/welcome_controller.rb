class WelcomeController < ApplicationController
  def index
    # if enter url like http://localhost:3000/tags/motivation then filter
    if params[:tag]
      # Sumpoints are ordered according to rank value (see sumpoint model file)
      @sumpoints = Sumpoint.order('rank DESC').tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
      authorize @sumpoints
    else
      @sumpoints = Sumpoint.order('rank DESC').paginate(page: params[:page], per_page: 10)
      authorize @sumpoints
    end
  end

  def about
  end

end

