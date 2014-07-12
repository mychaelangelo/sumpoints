class Post < ActiveRecord::Base
  has_many :sumpoints
  belongs_to :user
  belongs_to :format

  default_scope { order('created_at DESC') }

end
