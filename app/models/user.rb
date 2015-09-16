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

  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { by_name.where(admin: false)}

  def self.authenticate(username_or_email, password)
    user = User.find_by(email: username_or_email) || user = User.find_by(username: username_or_email)
    user && user.authenticate(password)
  end

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
end
