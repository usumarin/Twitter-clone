require 'rails_helper'

RSpec.describe 'Tweets', type: :system do

  before do
    @firstuser = create(:firstuser)
  end

  describe 'Tweets CRUD' do
    describe 'ログイン前' do
    end
    describe 'ログイン後' do
      it 'ツイートフォームの入力値が正常(ツイート一覧)' do
        login(@firstuser)
        visit tweets_path
        fill_in 'tweet_content', with: 'test'
        click_button 'Tweetを投稿する'
        expect(page).to have_content '成功'
      end
      it 'ツイートフォームの入力値が正常(プロフィール)' do
        login(@firstuser)
        visit user_path(@firstuser)
        fill_in 'tweet_content', with: 'test'
        click_button 'Tweetを投稿する'
        expect(page).to have_content '成功'
      end
      it 'ツイート文字数が多すぎる(ツイート一覧)' do
        login(@firstuser)
        visit tweets_path
        fill_in 'tweet_content', with: 'a' * 141
        click_button 'Tweetを投稿する'
        expect(page).to have_content 'ツイートは140文字以内で入力してください'
      end
      it 'ツイート文字数が多すぎる(プロフィール)' do
        login(@firstuser)
        visit user_path(@firstuser)
        fill_in 'tweet_content', with: 'a' * 141
        click_button 'Tweetを投稿する'
        expect(page).to have_content 'ツイートは140文字以内で入力してください'
      end
    end
  end
end