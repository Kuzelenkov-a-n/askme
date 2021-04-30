class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  validates :text, presence: true, length: { maximum: 255 }
  after_save_commit :find_or_create_hashtags

  private

  def find_or_create_hashtags
    self.hashtags =
      "#{answer} #{text}".downcase
        .scan(Hashtag::HASHTAG_REGEXP).uniq
        .map { |hash| Hashtag.find_or_create_by(text: hash.delete('#')) }
  end
end
