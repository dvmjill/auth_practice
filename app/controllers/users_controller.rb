class UsersController < ApplicationController


#shows the register form
  def new
    @user = User.new
  end

  #POST request to reg a new user

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to edit_user_path
    else
      flash[:errors] = @user.errors.full_messages
      render :new
      # # flash = {
      # #   errors
      # # }
    end
  end


  #shows the edit form
  def edit
    unless session[:user_id].nil?
      @user = User.find(session[:user_id])
        if @user.id != params[:id].to_i
          redirect_to edit_user_path(@user)
        end
      else
      flash[:errors] = ["You must be logged in to edit"]
      redirect_to root_path
      end
    end

  #POST req to update a user's info
  def update

  end

  private
  def user_params
    params.require(:user).permit(:username, :password)

  end
end
