class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_spot, only: %i[show edit]

  def index
    @spots = Spot.includes(:artist).order(updated_at: "DESC")
  end

  def show
    @posts = @spot.posts.includes(:user).order(updated_at: "DESC")
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
      user_id: @spot.user_id
    )
  end

  def create
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id))
    if check_artist_name
      if @artist_spot.save
        redirect_to spots_path, notice: "聖地を登録しました"
      else
        flash.now[:alert] = "聖地の登録に失敗しました"
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "アーティスト名が正確ではない、もしくは「Spotify API」上にデータが存在しません"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id, id: params[:id]))
    if check_artist_name
      if @artist_spot.save
        redirect_to spot_path(@artist_spot.id), notice: "聖地を更新しました"
      else
        flash.now[:alert] = "聖地の更新に失敗しました"
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "アーティスト名が正確ではない、もしくは「Spotify API」上にデータが存在しません"
      render :edit, status: :unprocessable_entity
    end
  end

  def bookmarks
    @bookmark_spots = current_user.bookmark_spots.includes(:artist).order(created_at: :desc)
  end

  private

  def spot_params
    params.require(:artist_spot).permit(:tag, :spot_name, :name, :detail)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

  #「Spotify API上のデータと比較することで正確なアーティスト名が入力されているかチェックするメソッド
  def check_artist_name
    artist_name = params["artist_spot"]["name"]

    return false unless artist_name.present?

    spotify_data = RSpotify::Artist.search(artist_name).first

    return false unless spotify_data

    spotify_name = spotify_data.name
    artist_name == spotify_name
  end
end
