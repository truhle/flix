class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence:true
  validates :email, presence:true,
                    format: /\A\S+@.+\.\S+\z/,
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }
  validates :username, presence: true,
                    format: /\A\w+$\z/,
                    uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
end
