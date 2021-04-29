class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  validates :text, presence: true, length: { maximum: 255 }
  after_commit :find_or_create_hashtags, on: [:create, :update]

  private

  def hashtags_searcher
    "#{answer} #{text}".scan(Hashtag::HASHTAG_REGEXP)
  end

  def find_or_create_hashtags
    self.hashtags = hashtags_searcher&.map { |hash| Hashtag.find_or_create_by(text: hash) }
  end
end
