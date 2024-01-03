class ArtistSpot
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :tag, :spot_name, :name, :detail, :user_id

  with_options presence: true do
    validates :tag
    validates :spot_name
    validates :name
    validates :user_id
  end

  def save
    ActiveRecord::Base.transaction do
      artist = Artist.create(name:)
      Spot.create!(tag:, spot_name:, detail:,user_id:, artist_id: artist.id)
    end
  end
end
