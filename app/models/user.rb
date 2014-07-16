class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  # depdent: :destroy means when a user is deleted, so is his associated objects
  has_many :postvotes, dependent: :destroy
  has_many :followedposts, dependent: :destroy
  has_many :sumpoints
  has_many :likes, dependent: :destroy


  def role?(base_role)
    # Implied self i.e. don't have to write self.role
    role == base_role.to_s
  end

  # check if user has followed a post, otherwise returns nil
  def followed_post(post)
    self.followedposts.where(post_id: post.id).first
  end

end
