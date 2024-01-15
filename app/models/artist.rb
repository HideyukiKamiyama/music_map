class Artist < ApplicationRecord
  has_many :spots, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(_auth_object = nil)
    ["name"]
  end
end
