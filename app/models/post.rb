class Post < ActiveRecord::Base
  
  has_many :sumpoints, dependent: :destroy # the dependent means if we delete post, it deletes sumpoints too
  belongs_to :user
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
  validates :user, presence: true
  validates_presence_of :sumpoints



end
