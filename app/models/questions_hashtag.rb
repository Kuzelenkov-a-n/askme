class QuestionsHashtag < ApplicationRecord
  belongs_to :question
  belongs_to :hashtag, dependent: :destroy
end
