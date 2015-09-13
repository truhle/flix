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
    expect(page).to have_link(user.name)
    expect(page).to have_link("Sign Out")
    expect(page).not_to have_link("Sign In")
    expect(page).not_to have_link("Sign Up")
  end

  it 'shows user sign in page with invalid email/password' do
    user = User.create!(user_attributes)

    visit signin_url

    fill_in "Username or email", with: user.email
    fill_in "Password", with: "incorrect"

    click_button "Sign In"

    expect(current_path).to eq(session_path)
    expect(page).to have_text("Invalid")
    expect(page).not_to have_link(user.name)
    expect(page).not_to have_link("Sign Out")
    expect(page).to have_link("Sign In")
    expect(page).to have_link("Sign Up")
  end
end
