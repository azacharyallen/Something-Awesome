class PrivateMessagesController < ApplicationController
before_action :ensure_login!

  def index
    @messages = current_user.received_messages.includes(:author).order(:created_at).reverse_order.page(params[:page] || 1)
    # render :json => @messages#placeholder
  end
  
  def show
    @message = PrivateMessage.find(params[:id])
    authorize! :read, @message, message: "You may not look at other people's private messages!"
    @message.update_attributes(read: TRUE) unless @message.read
    #placeholder
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
