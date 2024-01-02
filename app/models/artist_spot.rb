class ArtistSpot < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  validates :name, presence: true, length: { maximum: 255 }
  validates :detail, length: { maximum: 65_535 }
  validates :tag, presence: true
end
