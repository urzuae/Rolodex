class ApplicationController < ActionController::Base
  #include Twitter::AuthenticacionHelpers
  
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  helper_method :current_user
  #rescue_from Twitter::Unauthorized, :with => :force_sign_in
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  def oauth
    @oauth ||= Twitter::Oauth.new(ConsumerToken, ConsumerSecret, :sign_in => true)
  end
  def client
    oauth.authorize_from_access(session[:atoken], session[:asecret])
    Twitter::Base.new(oauth)
  end
  helper_method :client
  def force_sign_in(exception)
    reset_session
    flash[:error] = 'Please sign in again'
    redirect_to new_session_path
  end
end
