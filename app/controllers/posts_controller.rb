class PostsController < ApplicationController
before_action :ensure_login!, except: [:show, :index]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:user).where(user_id: @user.id)
  end
  
  def show
    @post = Post.includes(:user).find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.post_thread_id = params[:post_thread_id]

    if @post.save
      @post.post_thread.touch
      flash[:notice] = "WOOOOOOO, YOU POSTED"
      redirect_to post_thread_url(params[:post_thread_id])
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_thread_url(params[:post_thread_id])
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.edited = "Edited by #{current_user.username} at #{@post.updated_at}" 
    if @post.update_attributes(post_params)
      flash[:notice] = "Your post was edited!"
      redirect_to post_thread_url(@post.post_thread_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    #placeholder
  end
  private
  def post_params
    params.require(:post).permit(:body)
  end
end
