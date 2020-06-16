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
      redirect_to tweets_path
    else
      render "new"
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
