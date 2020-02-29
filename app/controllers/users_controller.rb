class UsersController < ApplicationController

  def new
    authorize! :new, User
    
    @user = User.new
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
