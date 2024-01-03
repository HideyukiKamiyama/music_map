class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @spots = Spot.all
  end

  def show; end

  def new
    @spot = ArtistSpot.new
  end

  # def edit; end

  def create
    @spot = ArtistSpot.new(spot_params.merge(user_id: current_user.id))
    if @spot.save
      redirect_to spots_path
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
end
