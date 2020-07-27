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
        it 'パスワードと確認用パスワードの不一致' do
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

    describe 'ログイン後' do
      describe 'ユーザー編集' do
        it 'フォームの入力値が正常' do
          login(:firstuser)
          visit edit_user_registration_path
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end

        it 'ユーザー名の更新' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_name', with: 'test'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
        it 'メールアドレスの更新' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_email', with: 'test@example.com'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
        it 'プロフィールの更新' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_profile', with: 'test'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
        it 'パスワードの更新' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_password', with: 'passpass'
          fill_in 'user_password_confirmation', with: 'passpass'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
        it 'メールアドレス未入力' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_email', with: ''
          fill_in 'user_name', with: 'test-user'
          fill_in 'user_profile', with: 'test'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'メールアドレスを入力してください'
        end
        it 'ユーザー名未入力' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_email', with: 'factory@example.com'
          fill_in 'user_name', with: ''
          fill_in 'user_profile', with: 'test'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'ユーザー名は1文字以上で入力してください'
        end
        it 'ユーザープロフィールが長すぎる' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_profile', with: 'a' * 201
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'プロフィールは200文字以内で入力してください'
        end
        it 'パスワードと確認用パスワードの不一致' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_email', with: 'factory@example.com'
          fill_in 'user_name', with: ''
          fill_in 'user_profile', with: 'test'
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'ユーザー名は1文字以上で入力してください'
        end
        it 'パスワードの長さが足りない' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_password', with: 'a' * 4
          fill_in 'user_password_confirmation', with: 'a' * 4
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'パスワードは6文字以上で入力してください'
        end
        it 'パスワードが長すぎる' do
          login(:firstuser)
          visit edit_user_registration_path
          fill_in 'user_password', with: 'a' * 17
          fill_in 'user_password_confirmation', with: 'a' * 17
          click_button 'ユーザー情報を更新する'
          expect(page).to have_content 'パスワードは16文字以内で入力してください'
        end
      end
    end
  end
end