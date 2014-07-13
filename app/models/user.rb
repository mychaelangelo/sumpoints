class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  has_many :postvotes, dependent: :destroy


  def role?(base_role)
    # Implied self i.e. don't have to write self.role
    role == base_role.to_s
  end

end
