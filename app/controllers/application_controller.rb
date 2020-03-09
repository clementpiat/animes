class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      else
        @current_user = nil
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to main_app.root_url, :alert => exception.message }
      end
    end
end
