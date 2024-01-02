class Artist < ApplicationRecord
  has_many :spots, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
end
