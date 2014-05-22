class PostsController < ApplicationController
  def index
    #placeholder
  end
  
  def show
    #placeholder
  end
  
  def new
    #placeholder
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.post_thread_id = params[:post_thread_id]

    if @post.save
      flash[:notice] = "WOOOOOOO, YOU POSTED"
      redirect_to post_thread_url(params[:post_thread_id])
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_thread_url(params[:post_thread_id])
    end
  end
  
  def edit
    #placeholder
  end
  
  def update
    #placeholder
  end
  
  def destroy
    #placeholder
  end
  private
  def post_params
    params.require(:post).permit(:body)
  end
end
