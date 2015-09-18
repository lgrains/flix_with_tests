class Movie < ActiveRecord::Base
  def flop?
    total_gross < 50000000.0
  end

  def self.released
    Movie.where("released_on <= ?", Time.now).order("released_on desc")
  end

  def self.hit_movies
    Movie.where("total_gross >= ?", 300_000_000)
  end

  def self.flop_movies
    Movie.where("total_gross < ?", 50_000_000)
  end

  def self.recently_added_movies
    Movie.order("created_at desc").limit(3)
  end
end
