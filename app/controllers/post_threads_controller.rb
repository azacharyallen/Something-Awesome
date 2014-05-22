class PostThreadsController < ApplicationController
  before_action :ensure_login!, except: [:show, :index]

  def index
    #placeholder
  end
  
  def show
    @thread = PostThread.includes(posts: :user).find(params[:id])
  end
  
  def new
    @post_thread = PostThread.new
  end
  
  def create
    @post_thread = PostThread.new(post_thread_params)
    @post_thread.user = current_user
    @post_thread.forum_id = params[:forum_id]

    @post = @post_thread.posts.new(post_params)
    @post.user = current_user

    if @post_thread.save
      flash[:notice] = "You created a super new thread, congratulations!"
      redirect_to post_thread_url(@post_thread)
    else
      flash[:errors] = @post_thread.errors.full_messages
      render :new
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
  def post_thread_params
    params.require(:post_thread).permit(:title)
  end
  def post_params
    params.require(:post).permit(:body)
  end
end
