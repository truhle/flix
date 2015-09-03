describe "Creating a new review" do
  it 'saves the review' do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    click_link 'Write Review'

    expect(current_path).to eq(new_movie_review_path(movie))

    fill_in "Name", with: "Roger Ebert"
    fill_in "Location", with: "Chicago, IL"
    choose "review_stars_3"
    fill_in "Comment", with: "I laughed, I cried, I spilled my popcorn!"

    click_button 'Post Review'

    expect(current_path).to eq(movie_reviews_path(movie))

    expect(page).to have_text("Thanks for your review!")
  end

  it 'does not save the movie review if it is invalid' do
    movie = Movie.create(movie_attributes)

    visit new_movie_review_url(movie)

    expect {
      click_button "Post Review"
    }.not_to change(Review, :count)

    expect(page).to have_text('error')
  end
end