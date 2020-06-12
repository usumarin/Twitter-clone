class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(id: :DESC)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:success] = "成功"
    else
      flash[:danger] = "失敗"
      render "root_path"
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
