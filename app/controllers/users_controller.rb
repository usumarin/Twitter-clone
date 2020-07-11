class UsersController < ApplicationController

  def index
    @users = User.all
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find_by(id: params[:id])
    @tweets = @user.tweets.page(params[:page]).per(5).order("created_at DESC")
    @tweet = Tweet.new
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
