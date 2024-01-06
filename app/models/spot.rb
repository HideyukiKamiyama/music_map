class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_many :bookmarks, dependent: :destroy

  validates :spot_name, presence: true, length: { maximum: 255 }
  validates :detail, length: { maximum: 65_535 }
  validates :tag, presence: true

  enum tag: { video_location: 0, sign: 1, others: 2 }
end
