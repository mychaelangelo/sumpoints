class Format < ActiveRecord::Base

  # can do stuff like post.format.name and it returns string for format type
  has_many :posts
end
