class Movie < ActiveRecord::Base

  def flop?
    total_gross.blank? || total_gross < 50_000_000
  end

  def self.released
    where("released_on < ?", Time.now).order("released_on desc")
  end

  def self.hits
    where("total_gross >= ?", 300_000_000).order("released_on desc")
  end

  def self.flops
    where("total_gross < ?", 50_000_000).order("total_gross")
  end

  def self.recently_added
    order("created_at desc").limit(3)
  end
end

Movie.released.flops
