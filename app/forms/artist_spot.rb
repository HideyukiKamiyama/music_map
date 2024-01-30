class ArtistSpot
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :id, :tag, :spot_name, :name, :detail, :address, :latitude, :longitude, :images, :images_cache, :user_id

  with_options presence: true do
    validates :tag
    validates :spot_name
    validates :address
    validates :user_id
  end

  validate :images_count_validation
  validate :check_artist_name

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      artist = Artist.find_or_create_by(name:)
      if id.present?
        spot = Spot.find(id)
        spot.update(tag:, spot_name:, detail:, address:, latitude:, longitude:, images:, artist_id: artist.id)
      else
        Spot.create(tag:, spot_name:, detail:, address:, latitude:, longitude:, images:, user_id:, artist_id: artist.id)
      end
    end
  end

  private

  def images_count_validation
    valid_images = images.compact_blank
    errors.add(:images, :too_many) if valid_images.size > 4
  end

  # 「Spotify API上のデータと比較することで正確なアーティスト名が入力されているかチェックするバリデーション
  def check_artist_name
    if name.blank?
      errors.add(:name, :input_artist_name)
    else
      spotify_data = RSpotify::Artist.search(name).first
      errors.add(:name, :no_artist_data) unless spotify_data

      if spotify_data
        spotify_name = spotify_data.name
        errors.add(:name, :not_accurate_name) unless name == spotify_name
      end
    end
  end
end
