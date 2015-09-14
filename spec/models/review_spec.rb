describe "A review" do

  it 'belongs to a movie' do
    movie = Movie.create(movie_attributes)

    review = movie.reviews.new(review_attributes)

    expect(review.movie).to eq(movie)
  end

  it "is valid with example attributes" do
    review = Review.new(review_attributes)

    expect(review.valid?).to eq(true)
  end

  it 'requires a comment' do
    review = Review.new(comment: "")

    review.valid?

    expect(review.errors[:comment].any?).to eq(true)
  end

  it 'requires a comment over 3 characters' do
    review = Review.new(comment: "a" * 3)

    review.valid?

    expect(review.errors[:comment].any?).to eq(true)
  end

  it 'accepts star values of 1 through 5' do
    stars = [1, 2, 3, 4, 5]
    stars.each do |star|
      review = Review.new(stars: star)

      review.valid?

      expect(review.errors[:stars].any?).to eq(false)
    end
  end

  it 'rejects invalid star values' do
    stars = [-1, 0, 6]
    stars.each do |star|
      review = Review.new(stars: star)

      review.valid?

      expect(review.errors[:stars].any?).to eq(true)
      expect(review.errors[:stars].first).to eq("must be between 1 and 5")
    end
  end

  it 'accepts valid "city, state" locations' do
    locations = ["New York, New York", "Los Angeles, CA", "Chicago, Illinois"]

    locations.each do |location|
      review = Review.new(location: location)
      review.valid?
      expect(review.errors[:location].any?).to eq(false)
    end
  end

  it 'rejects invalid "city, state" locations' do
    locations = ["New York, ", " , CA", "Chicago"]

    locations.each do |location|
      review = Review.new(location: location)
      review.valid?
      expect(review.errors[:location].any?).to eq(true)
    end
  end
end
