class Movie < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations
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

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :hits, -> { released.where("total_gross >= ?", 300_000_000).order("total_gross desc") }
  scope :flops, -> { released.where("total_gross < ?", 50_000_000).order("total_gross") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :asc)}
  scope :rated, ->(rating) { released.where(rating: rating) }
  scope :recent, ->(max=5) { released.limit(max) }
  scope :grossed_less_than, ->(amount) { where("total_gross < ?", amount) }
  scope :grossed_greater_than, ->(amount) { where("total_gross > ?", amount) }


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

  def self.recently_added
    order("created_at desc").limit(3)
  end

  def recent_reviews
    reviews.order("created_at desc").limit(2)
  end
end

Movie.released.flops
