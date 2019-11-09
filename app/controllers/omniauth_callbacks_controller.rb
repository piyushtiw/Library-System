class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:notice] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:notice] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
    redirect_to root_path
  end
end
