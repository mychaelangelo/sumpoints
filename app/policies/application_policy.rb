class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  # Can only create if user is logged in
  def create?
    user.present?
  end

  def new?
    # same as create
    create?
  end

  def update?
    # user must be logged in, and must either be post creator or admin
    user.present? && (record.user == user || user.role?(:admin))
  end

  def edit?
    # same rules as update
    update?
  end

  def destroy?
    # same rules as update
    update?
  end

  def scope
    # will return class of record being authorised e.g. Post class
    record.class
  end
end

