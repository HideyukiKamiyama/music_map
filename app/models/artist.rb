class Artist < ApplicationRecord
  has_many :artist_spots, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
end
