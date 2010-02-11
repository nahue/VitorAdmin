# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :menu
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  helper_method :current_user,:roles,:role?
    
    
  def menu
  	@menu = [
  	      { :nombre => "Principal",
  			    :controlador => "principal",
  			    :accion => "index"},
  			  { :nombre => "Salir",
  			    :controlador => "user_sessions",
  			    :accion => "destroy"}
  			  ]
  end  
  
  private  
  def current_user_session  
    return @current_user_session if defined?(@current_user_session)  
    @current_user_session = UserSession.find  
  end  
    
  def current_user  
    @current_user = current_user_session && current_user_session.record  
  end  
  

  
end
