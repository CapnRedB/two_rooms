class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json
  # before_filter :configure_sign_in_params, only: [:create]


  # GET /users/signed_in
  def show
    unless current_user.nil?
      current_user.ensure_authentication_token
      current_user.save

      respond_to do |format|
        format.html
        format.json { render json: { token: current_user.authentication_token, email: current_user.email, name: current_user.name, user_id: current_user.id}, status: :ok }
      end
    end
  end

  # POST /user/sign_in
  def create
    super do |user|
      user.ensure_authentication_token
      user.save
      if json_request?
        render json: { token: user.authentication_token, email: user.email, name: user.name, user_id: user.id }, status: :created and return
      end
    end
  end

  # DELETE /user/sign_out
  # def destroy
  #   super    
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
