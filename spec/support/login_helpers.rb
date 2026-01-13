
module LoginHelpers
  def login_as(user)
    user.save! unless user.persisted?
    visit login_path
    fill_in 'user_email', with: user.email if page.has_field?('user_email', type: 'email')
    fill_in 'user_password', with: 'password' if page.has_field?('user_password', type: 'password')
    # fallback for non-prefixed fields
    fill_in 'email', with: user.email if page.has_field?('email', type: 'email')
    fill_in 'password', with: 'password' if page.has_field?('password', type: 'password')
    click_button 'Log in'
    expect(page).to have_current_path(tasks_path, wait: 5)
  end
end
