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
    @user = User.find(params[:user_id])
    render partial: "new_form"
  end
  
  def create
    #placeholder
    @message = PrivateMessage.new(private_message_params)
    @message.author = current_user
    @message.recipient_id = params[:user_id]

    if @message.save
      flash[:notice] = "Private Message sent!"
      redirect_to :back
    else
      flash[:errors] = @message.errors.full_messages
      redirect_to :back
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
  def private_message_params
    params.require(:private_message).permit(:title, :body)
  end
end
