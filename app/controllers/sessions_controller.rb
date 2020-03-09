class SessionsController < ApplicationController
  def new
    authorize! :new, SessionsController
  end

  def create
    authorize! :create, SessionsController

    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to root_url, notice: "Logged in!"
      else
        flash.now[:alert] = 'Please activate your account by following the instructions in the account confirmation email you received to proceed'
        render 'new'
      end
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end
  
  def destroy
    authorize! :destroy, SessionsController

    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end