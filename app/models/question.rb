class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  validates :text, presence: true, length: { maximum: 255 }
  after_save :find_or_create_hashtags, if: -> {
    Question.exists?(text: self.text) || Question.exists?(answer: self.answer)
  }

  private

  def hashtags_searcher
    answer_hashtags = answer&.scan(Hashtag::HASHTAG_REGEXP) || []
    text.scan(Hashtag::HASHTAG_REGEXP).union(answer_hashtags)
  end

  def find_or_create_hashtags
    self.hashtags = hashtags_searcher&.map { |hash| Hashtag.find_or_create_by(text: hash) }
  end
end
