class Users::SessionsController < Devise::SessionsController
  def destroy
    # Additional custom behavior (if needed) before logout
    super
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(_resource_or_scope)
    stored_location_for(_resource_or_scope) || root_path
  end
end