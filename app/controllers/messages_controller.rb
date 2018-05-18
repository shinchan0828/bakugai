class MessagesController < ApplicationController
  
  def show
    @messages = Message.all
  end
  
  def new
    @message = Message.new
    @request = Request.find(params[:request_id]) 
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path, notice: 'メッセージ送信に成功しました'
    else
      flash.now[:alert] = "メッセージ送信に失敗しました"
      render :new
    end
  end
  
  private 
  def message_params
    params.require(:message).permit(:content)
  end
end
