require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_REGEXP = /\A\w{4,40}\z/
  COLOR_REGEXP = /\A#\h{6}\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, format: { with: USERNAME_REGEXP }
  validates :color, presence: true, format: { with: COLOR_REGEXP }
  validates :email, :username, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, on: :create

  scope :sort_created_at, -> { order(:created_at) }

  before_validation :attr_downcase
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email.downcase)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def attr_downcase
    username&.downcase!
    email&.downcase!
  end
end
