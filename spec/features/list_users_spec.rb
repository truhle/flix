describe 'Viewing the list of users' do

  it 'shows the users' do
    user1 = User.create!(user_attributes(name: "Efren", email: "efren@example.com", username: "bata"))
    user2 = User.create!(user_attributes(name: "Earl", email: "earl@example.com", username: "The_Pearl"))
    user3 = User.create!(user_attributes(name: "Alex", email: "alex@example.com", username: "Lion"))

    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end

end
