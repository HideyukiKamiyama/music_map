class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: t(".notice")
    else
      flash.now[:alert] = t(".alert")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :avatar_cache)
  end
end
