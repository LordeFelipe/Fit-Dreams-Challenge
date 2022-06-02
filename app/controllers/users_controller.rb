class UsersController < ApplicationController

  acts_as_token_authentication_handler_for User, only: %i[logout], fallback_to_devise: false

  before_action :require_login, only: %i[logout]

  def signup 
    user = User.create!(user_params)
    render json: user, status: :created
  rescue StandardError => e
    render json:
    {
      message: 'Não foi possível cadastrar o usuário',
      description: e
    }, status: :bad_request
  end

  def login
    user = User.find_by!(email: user_params[:email])
    if user.valid_password?(user_params[:password])
      render json: user, status: :ok
    else
      head(:unauthorized)
    end
    rescue StandardError => e
      render json:
    {
      message: 'Email não encontrado.',
      description: e
    }, status: :not_found
  end

  def logout
    current_user.authentication_token = nil
    current_user.save!
    render json: {message: "Usuário deslogado com sucesso."}, status: :ok
    rescue StandardError => e
      render json: { message: e.message }, status: :bad_request
  end

  private

  def user_params
    params.permit(
      'email',
      'password',
      'password_confirmation',
      'name',
      'birthdate',
      'role_id'
    )
  end
end
