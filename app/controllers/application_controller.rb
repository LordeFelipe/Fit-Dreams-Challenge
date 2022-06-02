# frozen_string_literal: true

class ApplicationController < ActionController::API
  def require_login
    head(:unauthorized) unless current_user.presence
  end

  def admin_or_teacher_permission
    head(:forbidden) unless current_user.presence && (current_user.role == "admin" || current_user.role == "teacher")
  end

  def admin_permission
    head(:forbidden) unless current_user.presence && current_user.role == "admin"
  end
end
