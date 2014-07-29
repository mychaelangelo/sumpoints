class Sumpoint < ActiveRecord::Base
  # for tagging
  acts_as_taggable
  
  belongs_to :post
  belongs_to :user

  has_many :likes, dependent: :destroy


  # Default ordering of sumpoints is by date created
  default_scope { order ('created_at DESC') }

  # After each SumPoint created, call method 'send_follow_emails'
  after_create :send_follow_emails

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

  private

  def sumpoint_params
    params.require(:post).permit(:title, :user_id, :url, sumpoints_attributes: [:id, :body, :tag_list, :_destroy])
  end

  # Notify via email when new Sumpoint is created
  def send_follow_emails
    post.followedposts.each do |follow|
      if should_receive_update_for?(follow)
        FollowMailer.new_sumpoint(follow.user, post, self).deliver
      end
    end
  end

  # Email notifications should only be sent when (1) SumPoint is from other user and not self and (2) have permission to mail
  def should_receive_update_for?(follow)
    user_id != follow.user_id && follow.user.email_followed?
  end

end
