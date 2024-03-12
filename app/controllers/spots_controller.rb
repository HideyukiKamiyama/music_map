class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index show autocomplete]

  def index
    @q = Spot.ransack(params[:q])
    gon.spots = @q.result.includes(:artist).order(updated_at: "DESC")
    @spots = gon.spots.page(params[:page])
    gon.artists = Artist.all
  end

  def show
    @spot = Spot.find(params[:id])
    @comment = Comment.new
    @comments = @spot.comments.includes(:user).order(created_at: "DESC")
    gon.spot = @spot
  end

  def new
    @artist_spot = ArtistSpot.new
  end

  def edit
    spot = current_user.spots.find(params[:id])
    @artist_spot = ArtistSpot.new(
      id: spot.id,
      tag: spot.tag,
      spot_name: spot.spot_name,
      name: spot.artist.name,
      detail: spot.detail,
      user_id: spot.user_id,
      address: spot.address,
      latitude: spot.latitude,
      longitude: spot.longitude
    )
  end

  def create
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id))
    if @artist_spot.save
      spot = Spot.last
      redirect_to spot_path(spot), notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @artist_spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id, id: params[:id]))
    if @artist_spot.save
      redirect_to spot_path(@artist_spot.id), notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    spot = current_user.spots.find(params[:id])
    spot.destroy!
    redirect_to spots_path, notice: t('.notice'), status: :see_other
  end

  def bookmarks
    @q = current_user.bookmark_spots.ransack(params[:q])
    gon.spots = @q.result.includes(:artist).order(created_at: :desc)
    @bookmark_spots = gon.spots.page(params[:page])
    gon.artists = Artist.all
  end

  def autocomplete
    @artists = Artist.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  private

  def spot_params
    params.require(:artist_spot).permit(:tag, :spot_name, :name, :detail, :address, :latitude, :longitude, { images: [] }, :images_cache)
  end
end
