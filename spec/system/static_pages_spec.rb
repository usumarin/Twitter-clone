require 'rails_helper'

RSpec.describe 'static_pages', type: :system do

  describe 'Root' do
    specify '画面の表示' do
      visit root_path
      expect(page).to have_title 'TwitterClone'
    end
  end

  describe 'tweets#New' do
    specify '画面の表示' do
      visit new_path
      expect(page).to have_css('h1', text: 'Tweetを投稿する')
    end
  end

  describe 'tweets#index' do
    specify '画面の表示' do
      visit tweets_path
      expect(page).to have_css('h1', text: 'ツイート一覧')
    end
  end
end
