describe "Creating a movie" do
  it "saves the movie and shows the new movie's details" do
    visit movies_url
    click_link 'Add New Movie'
    expect(current_path). to eq(new_movie_path)

    fill_in "Title", with: "New Movie Title"
    fill_in "Description", with: "Superheroes saving the world from villians."
    fill_in "Total gross", with: "75000000"
    fill_in "Released on", with: (Time.now.year - 1).to_s

    click_button 'Create Movie'

    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text('New Movie Title')
  end
end
