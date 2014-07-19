class ApplicationController < ActionController::Base
  # Pundit is a gem for authorising users for different tasks, 
  # including it here means we can gain access to its methods in controllers and views
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]


  # When policy is not met, redirect to root_url and display error message
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
    #redirect_to root_url, alert: "You must be signed in" - can use this line instead
  end

  def ensure_signup_complete
    # Ensure don't go into infinite loop
    return if action_name == 'finish_signup'

    # Redirect to 'finish_signup' page if the user email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end 


end
