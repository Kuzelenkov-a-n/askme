require 'openssl'
require 'valid_email'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions

  validates :email, presence: true, email: true
  validates :username, presence: true, length: { maximum: 40 }
  validate :check_username, on: :create
  validates :email, :username, uniqueness: true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def check_username
    username.downcase!
    errors.add(
      :username, "may only contain any latin letters, numbers and '_'"
    ) unless username =~ /^[a-zA-Z\d_]*$/
  end

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

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return nil unless user.present?
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password
    nil
  end
end
