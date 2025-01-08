class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.present?
      # sign_out_all_scopes
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_session_path, alert: 'There was a problem signing you in through Google. Please register or try signing in later.'
    end
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed, please try again.'
  end
end
