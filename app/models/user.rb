class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :spots, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_spots, through: :bookmarks, source: :spot
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object&.user_id
  end

  def bookmark(spot)
    bookmark_spots << spot
  end

  def unbookmark(spot)
    bookmark_spots.destroy(spot)
  end

  def bookmark?(spot)
    bookmark_spots.include?(spot)
  end
end
