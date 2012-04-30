class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :set_user_status
  before_filter :check_active

  def set_user_status
    return unless current_user

    if current_user.status == 'kick_off'
      current_user.update_attribute :status, 'offline'
      reset_session
      redirect_to root_path
      return
    end

    status = case "#{params[:controller]}##{params[:action]}"
    when 'games#show'
      'in a game'
    when 'guesses#create'
      'in a game'
    when 'devise/sessions#destroy'
      'offline'
    else
      'online'
    end

    if current_user.status != status
      current_user.update_attribute :status, status
    end
  end

  def check_active
    if current_user && !current_user.active?
      reset_session
      current_user.update_attribute :status, 'offline'
    end
  end
end
