class PostPolicy < ApplicationPolicy
  # Allow posts index to be accessible to all
  def index?
    true
  end

end