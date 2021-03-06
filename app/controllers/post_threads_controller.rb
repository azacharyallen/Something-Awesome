class PostThreadsController < ApplicationController
  before_action :ensure_login!, except: [:show]

  def index
    # Placeholder
  end
  
  def show
    @thread = PostThread.includes(forum: :section).find(params[:id])
    @posts = Post.includes(:user).where(post_thread_id: params[:id]).order(:id).page(params[:page] || 1)

    if logged_in?
      @visit = Visit.find_by_user_and_thread(current_user.id, @thread.id)
      if @visit
        @visit.update_attributes(post: @posts.last)
      else
        @visit = Visit.create!(user: current_user, post_thread: @thread, post: @posts.last)
      end
    end
  end
  
  def new
    authorize! :create, PostThread
    @post_thread = PostThread.new
    @post_thread.forum_id = params[:forum_id]
    render partial: "new_form"
  end
  
  def create
    authorize! :create, PostThread
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
    @post_thread = PostThread.find(params[:id])
    authorize! :update, @post_thread

    if @post_thread.update_attributes(post_thread_params)
      flash[:notice] = "Thread updated, thanks!"
      return head :ok
    else
      flash[:errors] = @post_thread.errors.full_messages
      return head 303
    end
  end
  
  def destroy
    #placeholder
  end

  private
  def post_thread_params
    params.require(:post_thread).permit(:title, :closed)
  end
  def post_params
    params.require(:post).permit(:body)
  end
end
