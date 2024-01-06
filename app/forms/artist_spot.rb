class ArtistSpot
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :id, :tag, :spot_name, :name, :detail, :user_id

  with_options presence: true do
    validates :tag
    validates :spot_name
    validates :name
    validates :user_id
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      artist = Artist.find_or_create_by(name: name)
      if id.present?
        spot = Spot.find(id)
        spot.update(tag: tag, spot_name: spot_name, detail: detail, artist_id: artist.id)
      else
        Spot.create(tag: tag, spot_name: spot_name, detail: detail, user_id: user_id, artist_id: artist.id)
      end
    end
  end
end
