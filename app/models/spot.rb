class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :spot_name, presence: true, length: { maximum: 255 }
  validates :detail, length: { maximum: 65_535 }
  validates :tag, presence: true

  enum tag: { video_location: 0, sign: 1, others: 2 }

  geocoded_by :address
  after_validation :geocode

  def self.ransackable_attributes(_auth_object = nil)
    %w[artist_id detail spot_name tag]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[artist bookmarks comments user]
  end
end
