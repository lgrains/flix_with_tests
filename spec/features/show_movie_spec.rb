require "spec_helper"

RSpec.describe "Viewing movie details" do
  it "shows the movie details" do
    movie = Movie.create(movie_attributes(total_gross: 60000000.00))

    visit movie_path(movie.id)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
  end

  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create(movie_attributes(total_gross: 60000000.00))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 40000000.00))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end
end
