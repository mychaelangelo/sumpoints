class User < ActiveRecord::Base

  # for where user signups with Twitter (twitter doesn't provider user email)
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  # depdent: :destroy means when a user is deleted, so is his associated objects
  has_many :posts, dependent: :destroy
  has_many :postvotes, dependent: :destroy
  has_many :followedposts, dependent: :destroy
  has_many :sumpoints, dependent: :destroy
  has_many :likes, dependent: :destroy


  def role?(base_role)
    # Implied self i.e. don't have to write self.role
    role == base_role.to_s
  end

  # check if user has followed a post, otherwise returns nil
  def followed_post(post)
    self.followedposts.where(post_id: post.id).first
  end

  # find the omniauth of user (i.e. twitter or facebook etc)
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides existing user
    # to prevent identity being locked with accidentally created accounts.
    # Note - may leave zombie accounts (with no associated identity) which
    # can be cleaned up at later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create user if needed
    if user.nil?
      # Get existing user by email if provider gives us a verified email.
      # If no verified email was provided we assign a temp email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          # username: auth.info.nickname || auth.uid
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate identity with user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

end
