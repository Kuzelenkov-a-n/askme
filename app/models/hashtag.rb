class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags

  validates :text, presence: true, uniqueness: true, format: { with: HASHTAG_REGEXP }, length: { maximum: 255 }

  before_validation :hashtag_downcase

  private

  def hashtag_downcase
    text&.downcase!
  end
end
