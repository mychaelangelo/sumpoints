class FormatsController < ApplicationController
  
  # where 1 is 'articles' in the post.format.name
  def articles
    @posts = Post.where(format: 1)
  end

  def books
    @posts = Post.where(format: 2)
  end

  def videos
    @posts = Post.where(format: 3)
  end

  def audio
    @posts = Post.where(format: 4)
  end


end