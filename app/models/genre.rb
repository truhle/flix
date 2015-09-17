class Genre < ActiveRecord::Base

  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations

  before_validation :set_slug

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true


  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end
