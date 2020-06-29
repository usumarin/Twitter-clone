class TweetsController < ApplicationController
before_action :authenticate_user!, expect: :index

  def index
    @tweets = Tweet.all.order(id: :DESC)
    @user = User.find_by(id: @tweets.user_id)
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
      render "new"
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
