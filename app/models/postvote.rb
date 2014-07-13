class Postvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote."  }

  after_save :update_post
  # update rank of post every time a vote is cast and saved
  # update_rank is defined in the post.rb
  private

  def update_post
    self.post.update_rank
  end


end
