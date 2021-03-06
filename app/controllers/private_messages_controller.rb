class PrivateMessagesController < ApplicationController
before_action :ensure_login!

  def index
    @messages = current_user.received_messages.includes(:author).order(:created_at).reverse_order.page(params[:page] || 1)
    # render :json => @messages#placeholder
  end
  
  def show
    @message = PrivateMessage.includes(:author).find(params[:id])
    authorize! :read, @message, message: "You may not look at other people's private messages!"
    @message.update_attributes(read: TRUE) unless @message.read
    #placeholder
  end
  
  def new
    @message = PrivateMessage.new

    if params[:quote]
      quoted_message = PrivateMessage.includes(:author).find(params[:quote])
      @message.title = "Re: #{quoted_message.title}"
      @message.body = "[quote][b]#{quoted_message.author.username}[/b] said:[i]\n" + quoted_message.body + "\n[/i][/quote]" 
    end

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
    @message = PrivateMessage.find(params[:id])
    authorize! :destroy, @message, message: "You can't delete someone else's messages!"

    @message.try(:destroy)

    redirect_to private_messages_url
  end
  private
  def private_message_params
    params.require(:private_message).permit(:title, :body)
  end
end
