class ForumsController < ApplicationController
  def index
    #placeholder
  end
  
  def show
    # @forum = Forum.includes(:post_threads).find(params[:id])
    @forum = Forum.find(params[:id])
    @bookmarks = logged_in? ? current_user.bookmarked_threads.pluck(:id) : []
    @threads = PostThread.includes(:user, :posts).where(forum_id: params[:id]).order(:updated_at).reverse_order.page(params[:page] || 1)
  end
  
  def new
    #placeholder
  end
  
  def create
    #placeholder
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
end
