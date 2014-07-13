class Post < ActiveRecord::Base
  
  has_many :sumpoints, dependent: :destroy # the dependent means if we delete post, it deletes sumpoints too
  belongs_to :user
  belongs_to :format
  has_many :postvotes, dependent: :destroy
  has_many :followedposts, dependent: :destroy

  # allows you to save attributes on associated records through the parent
  accepts_nested_attributes_for :sumpoints, :reject_if => :all_blank, :allow_destroy => true

  acts_as_taggable

  # Order posts by creation date
  #default_scope { order('created_at DESC') }

  # Order posts by rank
  default_scope { order('rank DESC') }

  # Validating inputs (can submit post without a sumpoint)
  validates :title, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates :format_id, presence: true
  validates :user, presence: true
  validates_presence_of :sumpoints

  # when user submits a post, he automatically votes up for it
  after_create :create_postvote

  def up_postvotes
    self.postvotes.where(value: 1).count
  end

  def down_postvotes
    self.postvotes.where(value: -1).count
  end

  def points
    self.postvotes.sum(:value).to_i
  end

  def update_rank
    # ranking algorithm
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    # update the rank
    self.update_attribute(:rank, new_rank)
  end

  private
  #private methods

  # user that creates a post automatically up votes it
  def create_postvote
    user.postvotes.create(value: 1, post: self)
  end

end
