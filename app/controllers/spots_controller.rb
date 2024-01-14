class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_spot, only: %i[show edit]

  def index
    @spots = Spot.includes(:artist).order(updated_at: "DESC").page(params[:page])
    gon.spots = @spots
    gon.artists = Artist.all
  end

  def show
    @posts = @spot.posts.includes(:user).order(updated_at: "DESC")
    gon.spot = @spot
  end

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
      user_id: @spot.user_id,
      address: @spot.address,
      latitude: @spot.latitude,
      longitude: @spot.longitude
    )
  end

  def create
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id))
    if check_artist_name
      if @artist_spot.save
        redirect_to spots_path, data: { turbo: false }, notice: t('.notice')
      else
        flash.now[:alert] = t('.alert')
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = t('.name')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id, id: params[:id]))
    if check_artist_name
      if @artist_spot.save
        redirect_to spot_path(@artist_spot.id), data: { turbo: false }, notice: t('.notice')
      else
        flash.now[:alert] = t('.alert')
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = t('.name')
      render :edit, status: :unprocessable_entity
    end
  end

  def bookmarks
    @bookmark_spots = current_user.bookmark_spots.includes(:artist).order(created_at: :desc).page(params[:page])
  end

  private

  def spot_params
    params.require(:artist_spot).permit(:tag, :spot_name, :name, :detail, :address, :latitude, :longitude)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

  # 「Spotify API上のデータと比較することで正確なアーティスト名が入力されているかチェックするメソッド
  def check_artist_name
    artist_name = params["artist_spot"]["name"]
    return false if artist_name.blank?

    spotify_data = RSpotify::Artist.search(artist_name).first
    return false unless spotify_data

    spotify_name = spotify_data.name
    artist_name == spotify_name
  end
end
