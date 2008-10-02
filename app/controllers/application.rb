# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time

  include AuthenticatedSystem
  
  # don't show passwords in logs
  filter_parameter_logging 'password'
  
  protect_from_forgery 

end
