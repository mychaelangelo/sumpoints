class Sumpoint < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_many :likes, dependent: :destroy

  # Default ordering of sumpoints is by rank value
  default_scope { order ('rank DESC') }

  ### LIKES/DISLIKES SECTION
  def up_likes
    likes.where(value: 1).count
  end

  def down_likes
    likes.where(value: -1).count
  end

  def sum_likes 
    likes.sum(:value).to_i
  end

  # returns % portion of likes compared to total
  def portion_of_likes
    (up_likes/(likes.count).to_f)*100
  end

  # ranking algorithm
  def update_rank
    age = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = sum_likes + age
    update_attribute(:rank, new_rank)
  end

end
