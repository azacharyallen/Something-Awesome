class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    username = "Someone Awesome ##{User.count + 1}"
    password = Faker::Internet.password
    @user = User.new(username: username, password: password)
  end

  # GET /users/1/edit
  def edit
    authorize! :update, @user, message: "You are not alowed to edit another user's profile"
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      flash[:notice] = "Welcome to the forums, #{@user.username}!"

      send_welcome_pm

      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize! :update, @user, message: "You are not alowed to edit another user's profile"
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated.  Woo!"
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :destroy, @user, message: "You are not allowed to destroy that resource"
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :avatar, :profile, :password, :password_confirmation)
  end

  def send_welcome_pm
    PrivateMessage.create!( title: "Welcome to the forums!", 
                            body:  "Welcome to the Something Awesome Forums!\n\n
                                    We're super exited to have you here.",
                            author_id: 1,
                            recipient_id: current_user.id)
  end
end
