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
    movie1 = Movie.create(movie_attributes(released_on: 2.months.ago, title: "1"))
    movie2 = Movie.create(movie_attributes(released_on: 1.month.ago, title: "2"))
    movie3 = Movie.create(movie_attributes(released_on: 1.week.ago, title: "3"))

    released_movies = Movie.released
    expect(released_movies).to eq([movie3, movie2, movie1])
  end

  it 'is upcoming when the release date is in the future' do
    movie1 = Movie.create(movie_attributes(released_on: 1.month.from_now))
    movie2 = Movie.create(movie_attributes(released_on: 1.month.ago))


    movies = Movie.upcoming
    expect(movies).to eq([movie1])
  end

  it 'returns movies rated a given rating' do
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago, rating: "PG"))
    movie2 = Movie.create(movie_attributes(released_on: 3.months.ago, rating: "PG-13"))
    movie3 = Movie.create(movie_attributes(released_on: 3.months.from_now, rating: "PG"))

    movies = Movie.rated("PG")
    expect(movies).to eq([movie1])
  end

  it 'does something' do

  end

  it 'requires a title' do
    movie = Movie.new(title: '')

    movie.valid?

    expect(movie.errors[:title].any?).to eq(true)
  end

  it 'requires a description' do
    movie = Movie. new(description: '')

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it 'requires a released on date' do
    movie = Movie.new(released_on: '')

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it 'requires a duration' do
    movie = Movie.new(duration: '')

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it 'requires a description over 24 characters' do
    movie = Movie.new(description: "a" * 24)

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it 'accepts a $0 total gross' do
    movie = Movie.new(total_gross: 0.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it 'accepts a positive total gross' do
    movie = Movie.new(total_gross: 10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it 'rejects a positive total gross' do
    movie = Movie.new(total_gross: -10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(true)
  end

  it 'accepts any rating that is in an approved list' do
    ratings = %w[G PG PG-13 R NC-17 NR]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(false)
    end
  end

  it 'rejects any rating that is not in an approved list' do
    ratings = %w[R-13 R-16 R-18 R-21 GP EG V]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(true)
    end
  end

  it 'is valid with example attributes' do
    movie = Movie.new(movie_attributes)

    expect(movie.valid?).to eq(true)
  end

  it "has many reviews" do
    movie = Movie.new(movie_attributes)

    review1 = movie.reviews.new(review_attributes)
    review2 = movie.reviews.new(review_attributes)

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes)

    expect {
      movie.destroy
    }.to change(Review, :count).by(-1)
  end

  it 'calculates the average number of review stars' do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes(stars: 1))
    movie.reviews.create(review_attributes(stars: 3))
    movie.reviews.create(review_attributes(stars: 5))

    expect(movie.average_stars).to eq(3)
  end

  it 'has fans' do
    movie = Movie.new(movie_attributes)
    fan1 = User.new(user_attributes(username: "First", email: "first@example.com"))
    fan2 = User.new(user_attributes(username: "Second", email: "second@example.com"))

    movie.favorites.new(user: fan1)
    movie.favorites.new(user: fan2)

    expect(movie.fans).to include(fan1)
    expect(movie.fans).to include(fan2)
  end

  it 'generates a slug attribute for URLs when it is saved' do
    movie = Movie.create!(movie_attributes)

    expect(movie.slug).to eq(movie.title.parameterize)
  end

  it 'requires a unique title' do
    movie1 = Movie.create!(movie_attributes)

    movie2 = Movie.new(movie_attributes(title: movie1.title))
    movie2.valid?
    expect(movie2.errors[:title].first).to eq("has already been taken")
  end

  it 'requires a unique slug' do
    movie1 = Movie.create!(movie_attributes)

    movie2 = Movie.new(movie_attributes(slug: movie1.slug))
    movie2.valid?
    expect(movie2.errors[:slug].first).to eq("has already been taken")
  end

  context "recent query" do
    before do
      @movie1 = Movie.create!(movie_attributes(released_on: 3.months.ago, title: "1"))
      @movie2 = Movie.create!(movie_attributes(released_on: 2.months.ago, title: "2"))
      @movie3 = Movie.create!(movie_attributes(released_on: 1.month.ago, title: "3"))
      @movie4 = Movie.create!(movie_attributes(released_on: 1.week.ago, title: "4"))
      @movie5 = Movie.create!(movie_attributes(released_on: 1.day.ago, title: "5"))
      @movie6 = Movie.create!(movie_attributes(released_on: 1.hour.ago, title: "6"))
      @movie7 = Movie.create!(movie_attributes(released_on: 1.day.from_now, title: "7"))
    end

    it 'returns a specified number of released movies ordered with the most recent movie first' do
      expect(Movie.recent(2)).to eq([@movie6, @movie5])
    end

    it 'returns a default of 5 released movies ordered with the most recent movie first' do
      expect(Movie.recent).to eq ([@movie6, @movie5, @movie4, @movie3, @movie2])
    end
  end
end
