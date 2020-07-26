require 'rails_helper'

RSpec.describe 'Users', type: :system do

  before do
    firstuser = create(:firstuser)
  end

  describe 'Users CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        it 'フォームの入力値が正常' do
          visit new_user_registration_path
          fill_in 'user_email', with: 'text@example.com'
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content 'アカウント登録が完了しました。'
        end
        it 'メールアドレス未入力' do
          visit new_user_registration_path
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content 'メールアドレスを入力してください'
        end
        it 'ユーザー名未入力' do
          visit new_user_registration_path
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content 'ユーザー名は1文字以上で入力してください'
        end
        it 'パスワード未入力' do
          visit new_user_registration_path
          fill_in 'user_email', with: 'text@example.com'
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content 'パスワードを入力してください'
        end
        it '確認用パスワード未入力' do
          visit new_user_registration_path
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
        end
        it 'パスワードと確認用パスワードが一致しない' do
          visit new_user_registration_path
          fill_in 'user_email', with: 'text@example.com'
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password1'
          click_button 'Sign up'
          expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
        end
        it '登録済みメールアドレス' do
          visit new_user_registration_path
          fill_in 'user_email', with: 'factory@example.com'
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content 'メールアドレスはすでに存在します'
        end
      end
    end

    # describe 'ログイン後' do
    #   describe 'ユーザー編集'
    #     context 'フォームの入力値が正常' do
          
    #     end

    #     context 'メールアドレス未記入' do
          
    #     end
    # end
  end
end