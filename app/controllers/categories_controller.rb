# frozen_string_literal: true

class CategoriesController < ApplicationController
  acts_as_token_authentication_handler_for User, only: %i[create update destroy], fallback_to_devise: false
  before_action :admin_or_teacher_permission, only: %i[create update destroy]

  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def show
    category = Category.find(category_params[:id])
    render json: category, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível encontrar a categoria',
      description: e
    }, status: :bad_request
  end

  def create
    category = Category.create!(category_params)
    render json: category, status: :created
  rescue StandardError => e
    render json:
    {
      message: 'Não foi possível criar a categoria',
      description: e
    }, status: :bad_request
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    render json: category, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível atualizar a categoria',
      description: e
    }, status: :bad_request
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy!
    render json: category, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível excluir a categoria',
      description: e
    }, status: :bad_request
  end

  private

  def category_params
    params.permit(
      'name',
      'description',
      'id'
    )
  end
end
