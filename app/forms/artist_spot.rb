class ArtistSpot
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :id, :tag, :spot_name, :name, :detail, :address, :latitude, :longitude, :images, :images_cache, :user_id

  with_options presence: true do
    validates :tag
    validates :spot_name
    validates :name
    validates :address
    validates :user_id
  end

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
end
