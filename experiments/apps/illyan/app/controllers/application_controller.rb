class ApplicationController < ActionController::Base
  protect_from_forgery :unless => :current_service
  layout 'application'

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    @current_ability ||= Ability.new(current_person)# || current_service)
  end

  def profile_name
    ENV['ILLYAN_ACCOUNT_NAME'] || "Profile"
  end
  helper_method :profile_name

  def current_service
    unless @_current_service
      # service_token = ActionController::HttpAuthentication::Token.token_and_options(request).presence.try(:first)
      # service_token ||= ActionController::HttpAuthentication::Basic::user_name_and_password(request).first if request.authorization.present?
      # service_token ||= params[:service_token].presence
      @_current_service = Service.find if :something# service_token
    end
    @_current_service
  end

  rescue_from CanCan::AccessDenied do
    if current_person
      render 'shared/access_denied'
    elsif current_service
      render :text => "Access denied for #{current_service.name} service", :status => :forbidden
    else
      flash[:alert] = "Please log in to access that page."
      redirect_to new_person_session_path
    end
  end

  protected
  def current_login_service
    @current_login_service ||= session[:login_service] && Service.find(session[:login_service])
  end
  helper_method :current_login_service

  def cleanup_login_service!
    session[:person_return_to] = nil
    session[:login_service] = nil
  end

  def configure_permitted_parameters
    [:firstname, :lastname, :birthdate, :gender].each do |param|
      devise_parameter_sanitizer.for(:sign_up) << param
    end
  end
end