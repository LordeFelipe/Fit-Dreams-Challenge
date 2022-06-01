# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def show
    category = Category.find(params(:id))
    render json: category, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível encontrar a categoria',
      description: e
    }, status: :bad_request
  end

  def create
    category = Category.create!(category_params)
    render json: category, status: :ok
  rescue StandardError => e
    render json:
    {
      message: 'Não foi possível criar a categoria',
      description: e
    }, status: :bad_request
  end

  def update
    category = Category.update!(category_params)
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
      'description'
    )
  end
end
