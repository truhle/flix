describe "Signing in" do


  it 'prompts for an email and password' do
    visit root_url

    click_link 'Sign In'

    expect(current_path).to eq(signin_path)

    expect(page).to have_field("Username or email")
    expect(page).to have_field("Password")
  end

  it 'signs user in with a valid email/password combo' do
    user = User.create!(user_attributes)

    visit signin_url

    fill_in "Username or email", with: user.email
    fill_in "Password", with: "secret"

    click_button "Sign In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Welcome back")
  end

  it 'shows user sign in page with invalid email/password' do
    user = User.create!(user_attributes)

    visit signin_url

    fill_in "Username or email", with: user.email
    fill_in "Password", with: "incorrect"

    click_button "Sign In"

    expect(current_path).to eq(session_path)
    expect(page).to have_text("Invalid")
  end
end
