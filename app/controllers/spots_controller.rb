class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_spot, only: %i[show edit]

  def index
    @spots = Spot.order(updated_at: "DESC")
  end

  def show; end

  def new
    @artist_spot = ArtistSpot.new
  end

  def edit
    @artist_spot = ArtistSpot.new(
      id: @spot.id,
      tag: @spot.tag,
      spot_name: @spot.spot_name,
      name: @spot.artist.name,
      detail: @spot.detail,
      user_id: @spot.user_id
    )
  end

  def create
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id))
    if check_artist_name
      if @artist_spot.save
        redirect_to spots_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def update
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id, id: params[:id]))
    if check_artist_name
      if @artist_spot.save
        redirect_to spot_path(@artist_spot.id)
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def bookmarks
    @bookmark_spots = current_user.bookmark_spots.order(created_at: :desc)
  end

  private

  def spot_params
    params.require(:artist_spot).permit(:tag, :spot_name, :name, :detail)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

  # Spotify API上のデータと比較することで正確なアーティスト名が入力されているかチェックするメソッド
  def check_artist_name
    artist_name = params["artist_spot"]["name"]
    spotify_name = RSpotify::Artist.search(artist_name).first.name
    return false unless spotify_name

    artist_name == spotify_name
  end
end
