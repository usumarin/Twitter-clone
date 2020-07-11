class TweetsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index
    @tweets = Tweet.all.order(id: :DESC)
    @tweets = Tweet.page(params[:page]).per(10)
    @tweet = Tweet.new
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(content: tweet_params[:content], user_id: current_user.id)
    if @tweet.save
      flash[:success] = "成功"
      redirect_to tweets_path
    else
      @user = current_user
      @tweets = current_user.tweets
      @tweets = current_user.tweets.page(params[:page]).per(10)
      render template: "users/show"
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
