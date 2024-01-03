class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :check_artist_name, only: %i[create]

  def index
    @spots = Spot.all.order(updated_at: "DESC")
  end

  def show; end

  def new
    @spot = ArtistSpot.new
  end

  # def edit; end

  def create
    if check_artist_name
      @spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id))
      if @spot.save
        redirect_to spots_path
      else
        render :new
      end
    else
      render :new
    end
  end

  # def update
  #   if @spot.update(spot_params)
  #     redirect_to @spot
  #   else
  #     render :edit
  #   end
  # end

  private

  def spot_params
    params.require(:artist_spot).permit(:tag, :spot_name, :name, :detail)
  end

  # Spotify API上のデータと比較することで正確なアーティスト名が入力されているかチェックするメソッド
  def check_artist_name
    artist_name = params["artist_spot"]["name"]
    spotify_data = RSpotify::Artist.search(artist_name).first
    spotify_name = spotify_data.name
    artist_name == spotify_name
  end
end
