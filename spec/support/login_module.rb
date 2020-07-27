module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'user_email', with: 'factory@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'ログイン'
  end
end