require 'rails_helper'

RSpec.describe 'static_pages', type: :system do

  describe 'Root' do
    it '画面の表示' do
      visit root_path
      expect(page).to have_title 'TwitterClone'
    end

    it 'リンクの調査' do
      visit root_path
      expect(page).to have_link 'Home', href: root_path
      expect(page).to have_link 'つぶやきをみる', href: tweets_path
      expect(page).to have_link 'TwitterClone', href: root_path
    end
  end
end
