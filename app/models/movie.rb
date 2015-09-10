class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_attached_file :image, styles: {
    small: "90x133>",
    thumb: "50x50>"
  }

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates_attachment :image,
    :content_type => { :content_type => ['image/jpeg', 'image/png'] },
    :size => { :less_than => 1.megabyte }
  RATINGS = %W(G PG PG-13 R NC-17 NR)
  validates :rating, inclusion: { in: RATINGS }


  def flop?
    if reviews.any?
      average_stars < 4 && ( total_gross.blank? || total_gross < 50_000_000 )
    else
      total_gross.blank? || total_gross < 50_000_000
    end
  end

  def average_stars
    reviews.average(:stars)
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

  def recent_reviews
    reviews.order("created_at desc").limit(2)
  end
end

Movie.released.flops
