class UsersController < ApplicationController

  def new
    authorize! :new, User
    
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    authorize! :create, @user

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      redirect_to main_app.login_url, notice: 'Please confirm your email address to continue' 
    else
      render :new
    end
  end
  
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:notice] = "Welcome to the Anime Playlist App! Your email has been confirmed. Please sign in to continue."
      redirect_to login_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :character)
    end
end
