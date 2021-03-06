class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    # provider = request.env["omniauth.auth"]["provider"]
    user = User.from_omniauth request.env["omniauth.auth"]
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes flash.notice = "Almost done, please provide password to complete registration"
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end
