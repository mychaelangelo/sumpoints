class LikePolicy < ApplicationPolicy
  # only members can like, per application policy
  def update?
    user.present? && (record.user == user || user.role?(:admin))
  end
end
