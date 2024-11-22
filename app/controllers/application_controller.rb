class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :initialize_session
  before_action :increment_visit_count
  helper_method :visit_count

  private

  def initialize_session
    session[:visit_count] ||= 0
  end

  def increment_visit_count
    session[:visit_count] += 1
  end

  def visit_count
    session[:visit_count]
  end
end
