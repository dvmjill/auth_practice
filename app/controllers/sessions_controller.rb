class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: session_params[:username])

    if @user && @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        redirect_to edit_user_path(@user)
    else
      @user ||= User.new
        flash[:errors] = ["Invalid Username/password combo"]
        render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

private

def session_params
  params.require(:user).permit(:username, :password)

end
end
