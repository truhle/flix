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

  it 'accepts properly formatted image file names' do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(false)
    end
  end

  it 'rejects improperly formatted image file names' do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(true)
    end
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
end
