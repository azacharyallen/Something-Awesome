class ForumsController < ApplicationController
  def index
    #placeholder
  end
  
  def show
    @forum = Forum.includes(:post_threads).find(params[:id])
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
