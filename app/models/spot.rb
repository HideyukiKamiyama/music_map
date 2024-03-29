class Spot < ApplicationRecord
  mount_uploaders :images, ImageUploader

  belongs_to :user
  belongs_to :artist
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :spot_name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true, length: { maximum: 65_535 }
  validates :tag, presence: true

  enum tag: { video_location: 0, sign: 1, others: 2 }

  geocoded_by :address
  after_validation :geocode

  def self.ransackable_attributes(_auth_object = nil)
    %w[tag]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[artist]
  end
end
