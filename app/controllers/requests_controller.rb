class RequestsController < ApplicationController
  def new
    @request = Request.new
    @request.commodities.build
  end
  
  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      redirect_to root_path, notice: '投稿に成功しました'
    else
      logger.debug('エラー内容は下記です')
      logger.debug(@request.errors.messages)
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end
  
  private
  def request_params
    params.require(:request).permit(:title, :budget, :description, commodities_attributes: [:product_name, :amount, :price, :image],)
  end
end
