class FollowedpostPolicy < ApplicationPolicy
  def update?
    user.present? && (record.user == user || user.role?(:admin))
  end
end