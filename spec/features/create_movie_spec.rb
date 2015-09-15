describe "Creating a movie" do
  before do
    genres = ["Action", "Drama", "Comedy"]
    genres.each do |genre|
      Genre.create!(name: genre)
    end
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "saves the movie and shows the new movie's details" do
    visit movies_url
    click_link 'Add New Movie'
    expect(current_path). to eq(new_movie_path)

    fill_in "Title", with: "New Movie Title"
    fill_in "Description", with: "Superheroes saving the world from villians."
    select "PG-13", from: "movie_rating"
    fill_in "Total gross", with: "75000000"
    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever creative director"
    fill_in "Duration", with: "123 min"
    attach_file "Image", "#{Rails.root}/app/assets/images/ironman.jpg"
    check("Action")
    check("Comedy")

    click_button 'Create Movie'

    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text('New Movie Title')

    expect(page).to have_text("Movie successfully created!")
    expect(page).to have_text("Action")
    expect(page).to have_text("Comedy")
    expect(page).not_to have_text("Drama")
  end

  it "does not save the movie if it's invalid" do
    visit new_movie_url

    expect {
      click_button 'Create Movie'
    }.not_to change(Movie, :count)

    expect(current_path).to eq(movies_path)
    expect(page).to have_text('error')
  end

  it "does not update the movie if it's invalid" do
    movie = Movie.create(movie_attributes)

    visit edit_movie_url(movie)

    fill_in 'Title', with: " "

    click_button 'Update Movie'

    expect(page).to have_text('error')
  end
end
