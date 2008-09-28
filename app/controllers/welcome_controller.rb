class WelcomeController < ApplicationController

  def index
    return unless current_user

    if current_user.has_role?("employer") or current_user.has_role?("employee")
      redirect_to :controller => "jobs", :action => "index"
    else 
      if current_user.has_role?("admin")
        flash[:notice] = "Welcome administrator!"
        render :action => 'admin'
      else  
        flash[:notice] = "You are neither employer or employee at the moment."
        render :action => 'norole'
      end
    end
  end
end
