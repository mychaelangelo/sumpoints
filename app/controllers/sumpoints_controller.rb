class SumpointsController < ApplicationController


  # shows Sumpoints by date of creation
  def index
    @sumpoints = Sumpoint.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def top
  end

end
