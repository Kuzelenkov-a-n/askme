class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags

  validates :text, presence: true, uniqueness: true, length: { maximum: 255 }

  scope :with_questions, -> { joins(:questions).distinct }

  def to_param
    self.text
  end
end
