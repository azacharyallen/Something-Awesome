class BookmarksController < ApplicationController
  before_action :ensure_login!
  
  def index
    @threads = current_user.bookmarked_threads.order(:updated_at).reverse_order.page(params[:page] || 1)
    # @threads = PostThread.page(1)
    @bookmarks = logged_in? ? current_user.bookmarked_threads.pluck(:id) : []
  end
  
  def show
    #placeholder
  end
  
  def new
    #placeholder
  end
  
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      return head :ok
    else
      return head 303
    end
  end
  
  def edit
    #placeholder
  end
  
  def update
    #placeholder
  end
  
  def destroy
    post_thread_id = params[:id]
    user_id = current_user.id
    @bookmark = Bookmark.where(post_thread_id: post_thread_id, user_id: user_id).first

    if @bookmark.try(:destroy)
      return head :ok
    else
      return head 303
    end
  end
  
  private
  def bookmark_params
    params.require(:bookmark).permit(:post_thread_id)
  end
end
