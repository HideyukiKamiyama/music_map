class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 255 }
end
