class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :sumpoint

  # a 1 is a like and a -1 is a dislike
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid like." }

  after_save :update_sumpoint
  # update rank of sumpoint every time a like is cast and saved
  # update_rank is defined in the sumpoint.rb
  private

  def update_sumpoint
    sumpoint.update_rank
  end


end 
