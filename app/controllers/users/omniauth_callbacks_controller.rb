class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
     social_auth_for("Github");
  end

  def facebook
     social_auth_for("Facebook")
  end

  private 
    def social_auth_for(provider)
      @user = User.find_for_oauth(request.env["omniauth.auth"])
       if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => provider) if is_navigational_format?
      else
        session["devise.{provider.downcase}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
end