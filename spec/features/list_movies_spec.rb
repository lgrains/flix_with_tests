require "spec_helper"

describe "Viewing the list of movies" do
  it "shows the movies" do

    movie1 = Movie.create(title: "Iron Man",
                    rating: "PG-13",
                    total_gross: 318412101.00,
                    description: "Tony Stark builds an armored suit to fight the throes of evil",
                    released_on: "2008-05-02")

    movie2 = Movie.create(title: "Superman",
                    rating: "PG",
                    total_gross: 134218018.00,
                    description: "Clark Kent grows up to be the greatest super-hero",
                    released_on: "1978-12-15")

    movie3 = Movie.create(title: "Spider-Man",
                    rating: "PG-13",
                    total_gross: 403706375.00,
                      description: "Peter Parker gets bit by a genetically modified spider",
                      released_on: "2002-05-03")

    visit movies_url

    expect(page).to have_text("3 Movies")
    expect(page).to have_text("Iron Man")
    expect(page).to have_text("Superman")
    expect(page).to have_text("Spider-Man")

    expect(page).to have_text(movie1.rating)
    expect(page).to have_text(movie1.description[0..9])
    expect(page).to have_text(movie1.released_on)
    expect(page).to have_text("$318,412,101.00")
  end

  it "does not show a movie that hasn't yet been released" do
    movie = Movie.create(movie_attributes(released_on: 1.month.from_now))

    visit movies_path

    expect(page).not_to have_text(movie.title)
  end

  # These tests can't be run concurrently until there are different methods in
  #   the controller, rather than just swapping out the method
  #   in MoviesController#index
  # it "shows hit movies" do
  #   movie1 = Movie.create(movie_attributes(total_gross: 350_000_000, title: "Hit Movie"))
  #   movie2 = Movie.create(movie_attributes(total_gross: 100_000_000, title: "Non-hit Movie"))

  #   visit movies_path

  #   expect(page).to have_text(movie1.title)
  #   expect(page).to_not have_text(movie2.title)
  # end

  # it "shows flop movies" do
  #   movie1 = Movie.create(movie_attributes(total_gross: 40_000_000, title: "Flop Movie"))
  #   movie2 = Movie.create(movie_attributes(total_gross: 60_000_000, title: "Non-flop Movie"))

  #   visit movies_path

  #   expect(page).to have_text(movie1.title)
  #   expect(page).to_not have_text(movie2.title)
  # end

  it "shows recently added movies" do
    movie1 = Movie.create(movie_attributes(created_at: 3.days.ago, title: "Movie One"))
    movie2 = Movie.create(movie_attributes(created_at: 2.days.ago, title: "Movie Two"))
    movie3 = Movie.create(movie_attributes(created_at: 14.days.ago, title: "Movie Three"))
    movie4 = Movie.create(movie_attributes(created_at: 6.days.ago, title: "Movie Four"))

    visit movies_path

    expect(page).to have_text(movie1.title)
    expect(page).to have_text(movie2.title)
    expect(page).to have_text(movie4.title)

    movie2.title.should appear_before(movie1.title)
    movie1.title.should appear_before(movie4.title)

    expect(page).to_not have_text(movie3.title)
  end
end
