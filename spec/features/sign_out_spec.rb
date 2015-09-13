describe "Sign out" do

  it 'signs out a user' do
    user = User.create!(user_attributes)

    sign_in(user)

    click_link "Sign Out"

    expect(page).to have_text("signed out")
    expect(page).not_to have_link("Sign Out")
    expect(page).not_to have_link(user.name)
    expect(page).to have_link("Sign In")
    expect(page).to have_link("Sign Up")
  end
end
