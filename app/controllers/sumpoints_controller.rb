class SumpointsController < ApplicationController


  # shows Sumpoints by date of creation
  def index
    @sumpoints = Sumpoint.paginate(page: params[:page], per_page: 10)
  end


end
