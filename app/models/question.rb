class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :text, presence: true, length: { maximum: 255 }
  validates :user, presence: true
end
