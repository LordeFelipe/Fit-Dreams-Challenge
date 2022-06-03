class LessonsController < ApplicationController
  acts_as_token_authentication_handler_for User, only: %i[create update destroy], fallback_to_devise: false
  before_action :admin_or_teacher_permission, only: %i[create update destroy]

  def index
    lessons = Lesson.all
    render json: lessons, status: :ok
  end

  def show
    lesson = Lesson.find(lesson_params[:id])
    render json: lesson, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível encontrar a turma',
      description: e
    }, status: :bad_request
  end

  def create
    lesson = Lesson.create!(lesson_params)
    render json: lesson, status: :created
  rescue StandardError => e
    render json:
    {
      message: 'Não foi possível criar a turma',
      description: e
    }, status: :bad_request
  end

  def update
    lesson = Lesson.find(params[:id])
    lesson.update(lesson_params)
    render json: lesson, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível atualizar a turma',
      description: e
    }, status: :bad_request
  end

  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy!
    render json: lesson, status: :ok
  rescue StandardError => e
    render json: {
      message: 'Não foi possível excluir a turma',
      description: e
    }, status: :bad_request
  end

  private

  def lesson_params
    params.permit(
      'name',
      'description',
      'start_time',
      'duration',
      'category_id',
      'id'
    )
  end
end
