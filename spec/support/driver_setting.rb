RSpec.configure do |config|
  config.before(:each, type: :system) do

    # RSpec実行時、ブラウザが自動で立ち上がり共同を確認できる
    # driven_by(:selenium_chrome)

    # RSpec実行時、ブラウザOFF
    driven_by(:selenium_chrome_headless)
  end
end
