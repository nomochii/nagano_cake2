# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  before_action :configure_permitted_parameters, only: [:create]

  protected
    def customer_state
      @customer = Customer.find_by(email: params[:customer][:email])
      return if !@customer
      if @customer.valid_password?(params[:customer][:password])
      end
    end

  def after_sign_in_path_for(resource)
      customers_my_page_path
  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :password])
  end
end
