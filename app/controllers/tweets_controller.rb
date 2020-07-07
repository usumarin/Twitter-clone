class TweetsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index
    @tweets = Tweet.all.order(id: :DESC)
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(content: tweet_params[:content], user_id: current_user.id)
    if @tweet.save
      flash[:success] = "戝功"
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
