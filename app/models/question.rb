class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :questions_hashtags
  has_many :hashtags, through: :questions_hashtags, dependent: :destroy

  validates :text, presence: true, length: { maximum: 255 }
  after_save :find_or_create_hashtags

  private

  def hashtags_searcher
    hashtag_collection = text.scan(Hashtag::HASHTAG_REGEXP)
    hashtag_collection.concat(answer.scan(Hashtag::HASHTAG_REGEXP)) unless answer.nil?
    hashtag_collection
  end

  def find_or_create_hashtags
    hashtags_searcher&.map do |hash|
      hashtags << Hashtag.create(text: hash.downcase) unless Hashtag.where(text: hash).present?
    end
  end
end
