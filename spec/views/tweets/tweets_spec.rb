require 'rails_helper'

RSpec.describe 'tweets', type: :system do
  
  describe 'tweets_path' do
    it '画面の表示' do
      visit tweets_path
      expect(page).to have_css('h1', text: 'ツイート一覧')
    end

    it 'リンクの調査' do
      visit tweets_path
      expect(page).to have_link 'Home', href: root_path
      expect(page).to have_link 'つぶやきをみる', href: tweets_path
      expect(page).to have_link 'TwitterClone', href: root_path
    end
  end
end
