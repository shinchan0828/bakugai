class RequestsController < ApplicationController
  
  def index
    @requests = Request.all
  end
  
  def show
    @request = Request.find(params[:id])
  end
  
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
      logger.debug(@request.commodities.inspect)
      logger.debug(@request.errors.messages)
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end
  
  private
  def request_params
    params.require(:request).permit(:title, :budget, :description, commodities_attributes: [:id, :product_name, :amount, :price, :image],)
  end
end
