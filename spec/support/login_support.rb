module LoginSupport
  def login(user)
    visit new_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include LoginSupport, type: :system
end