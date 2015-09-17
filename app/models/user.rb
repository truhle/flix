class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence:true
  validates :email, presence:true,
                    format: /\A\S+@.+\.\S+\z/,
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }
  validates :username, presence: true,
                    format: /\A\w+$\z/,
                    uniqueness: { case_sensitive: false }

  before_save :format_email
  before_save :format_username
  before_save :set_slug

  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { by_name.where(admin: false)}

  def self.authenticate(username_or_email, password)
    user = User.find_by(email: username_or_email) || user = User.find_by(username: username_or_email)
    user && user.authenticate(password)
  end

  def format_email
    self.email = email.downcase
  end

  def format_username
    self.username = username.downcase
  end

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def set_slug
    self.slug = username
  end

  def to_param
    username
  end
end
