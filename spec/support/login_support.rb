module LoginSupport
  def login(user)
    visit new_session_path
    fill_in 'Email address', with: user.email
    fill_in 'password', with: 'password'
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include LoginSupport, type: :system
end