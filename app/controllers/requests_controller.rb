class RequestsController < ApplicationController
  def new
    @request = Request.new
  end
  
  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      redirect_to root_path, notice: '投稿に成功しました'
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end
  
  private
  def request_params
    params.require(:request).permit(:title, :budget, :description)
  end
end
