

describe "Viewing a movie page" do

  it "shows the movie" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
    expect(page).to have_text(movie.cast)
    expect(page).to have_text(movie.director)
    expect(page).to have_text(movie.duration)
    expect(page).to have_selector("img[src$='#{movie.image.url(:small)}']")

  end

  it 'shows the total gross if the total gross exceeds $50M' do
    movie = Movie.create(movie_attributes(total_gross: 60_000_000))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it 'shows "Flop!" if the total gross is less than $50M' do
    movie = Movie.create(movie_attributes(total_gross: 49_000_000))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end

end
