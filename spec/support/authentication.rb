def sign_in(user)
  visit new_session_url
  fill_in "Username or email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end
