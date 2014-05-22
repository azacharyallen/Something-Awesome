class SessionsController < ApplicationController
  def index
    #placeholder
  end
  
  def show
    #placeholder
  end
  
  def new
    @user = User.new
  end
  
  # def create
  #   @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
  
  #   if @user
  #     login!(@user)
  #     redirect_to root_url
  #   else
  #     flash[:errors] ||= []
  #     flash[:errors] << "Invalid username and / or password"
  #     redirect_to new_session_url
  #   end
  # end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      login!(user)
      flash[:notice] = "Welcome back, #{user.username}"
      head :ok
    else
      head 400
    end
  end
  
  def edit
    #placeholder
  end
  
  def update
    #placeholder
  end
  
  def destroy
    logout!
    head :ok
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
