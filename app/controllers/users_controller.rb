class UsersController < ApplicationController
 before_action :authenticate_user!

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path(current_user)
    else
      render "devise/registrations/edit"
    end
  end

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        current_user.save
        sign_in(current_user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

 private

  # -- for the omniauth tutorial
  # def user_params
  #   accessible = [:name, :email] # extend with your own params
  #   #accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
  #   params.require(:user).permit(:name, :email)
  # end

  # old def user_params
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end