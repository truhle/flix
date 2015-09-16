describe "Filtering movies" do

  it 'shows hits' do
    hit = Movie.create!(movie_attributes(total_gross: 301_000_000))
    flop = Movie.create!(movie_attributes(total_gross: 1_000_000))

    visit movies_url
    click_link "Hits"

    expect(current_path).to eq("/movies/filter/hits")

    expect(page).to have_text(hit.title)
  end

  it 'shows flops' do
    hit = Movie.create!(movie_attributes(total_gross: 301_000_000))
    flop = Movie.create!(movie_attributes(total_gross: 1_000_000))

    visit movies_url
    click_link "Flops"

    expect(current_path).to eq("/movies/filter/flops")

    expect(page).to have_text(flop.title)
  end

  it 'shows upcoming movies' do
    recent = Movie.create!(movie_attributes(released_on: 1.day.ago))
    upcoming = Movie.create!(movie_attributes(released_on: 1.day.from_now))

    visit movies_url
    click_link "Upcoming"

    expect(current_path).to eq("/movies/filter/upcoming")

    expect(page).to have_text(upcoming.title)
  end

  it 'shows recent movies' do
    recent = Movie.create!(movie_attributes(released_on: 1.day.ago))
    upcoming = Movie.create!(movie_attributes(released_on: 1.day.from_now))

    visit movies_url
    click_link "Recent"

    expect(current_path).to eq("/movies/filter/recent")

    expect(page).to have_text(recent.title)
  end
end
