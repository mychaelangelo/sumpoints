class Post < ActiveRecord::Base
  has_many :sumpoints
  belongs_to :user
  belongs_to :format

  # allows you to save attributes on associated records through the parent
  accepts_nested_attributes_for :sumpoints, :reject_if => :all_blank, :allow_destroy => true

  acts_as_taggable

  default_scope { order('created_at DESC') }

end
