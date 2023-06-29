# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in

  if Rails.env.production?
    @@token_expired = 3.days.to_i
  else
    @@token_expired = 30.days.to_i
  end

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      payload = {
        user_uuid: @user.uuid,
        name: @user.name,
        exp: Time.now.to_i + @@token_expired,
      }
      token = JWT.encode payload, Rails.application.credentials.secret_key_base, Rails.application.credentials.token_algorithm
      render json: { token: token, uuid: @user.uuid, name: @user.name }
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
      }, status: :unauthorized
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def sign_in_params
    params.permit :email, :password
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    if @user
      return @user
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {},
      }, status: :failure
    end
  end
end
