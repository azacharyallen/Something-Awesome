class PostsController < ApplicationController
before_action :ensure_login!, except: [:show, :index]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:user).where(user_id: @user.id).order(:id).reverse_order.page(params[:page] || 1)
  end
  
  def show
    @post = Post.includes(:user).find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @post.to_json(include: :user) }
    end
  end
  
  def new
    authorize! :create, Post
    @post = Post.new()
    @thread = params[:post_thread_id]

    if params[:quote]
      quoted_post = Post.find(params[:quote])
      @post.body = "<blockquote><p><b><i>#{quoted_post.user.username}</b> said:</i>\n" + quoted_post.body + "</p></blockquote>\n" 
    end
    
    render partial: "new_form"
  end
  
  def create
    authorize! :create, Post
    @post = Post.new(post_params)
    @post.user = current_user
    @post.post_thread_id = params[:post_thread_id]
    if @post.save
      @destination_page = PostThread.find(params[:post_thread_id]).posts.page(1).num_pages
      @post.post_thread.touch
      flash[:notice] = "WOOOOOOO, YOU POSTED!"
      redirect_to post_thread_url(params[:post_thread_id]) + "?page=#{@destination_page}#post-#{@post.id}"
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_thread_url(params[:post_thread_id])
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    authorize! :update, @post
    render partial: "edit_form"
  end
  
  def update
    @post = Post.find(params[:id])
    authorize! :update, @post

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
