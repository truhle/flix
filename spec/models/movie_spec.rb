describe "A movie" do
  it 'is a flop if the total gross is less than $50M' do
    movie = Movie.new(total_gross: 49_000_000)

    expect(movie.flop?).to eq(true)
  end

  it 'is not a flop if the total gross is >= $50M' do
    movie = Movie.new(total_gross: 50_000_000)

    expect(movie.flop?).to eq(false)
  end

  it 'is released when the release date is in the past' do
    movie = Movie.create(movie_attributes(released_on: 1.month.ago))

    movies = Movie.released
    expect(movies).to include(movie)
  end

  it 'is not released when the release date is in the future ' do
    movie = Movie.create(movie_attributes(released_on: 1.month.from_now))

    movies = Movie.released
    expect(movies).not_to include(movie)
  end

  it 'lists released movies in order from the most recent first' do
    movie1 = Movie.create(movie_attributes(released_on: 2.months.ago))
    movie2 = Movie.create(movie_attributes(released_on: 1.month.ago))
    movie3 = Movie.create(movie_attributes(released_on: 1.week.ago))

    released_movies = Movie.released
    expect(released_movies).to eq([movie3, movie2, movie1])
  end
end
