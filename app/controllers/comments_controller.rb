class CommentsController < ApplicationController
  # before_action :set_comment, only: %i[edit update]

  # def edit; end

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to spot_path(comment.spot), data: { turbo: false }, notice: t(".notice")
    else
      redirect_to spot_path(comment.spot), data: { turbo: false }, alert: t(".alert")
    end
  end

  # def update
  #   if @comment.update(comment_params)
  #     redirect_to comment_path(@comment), notice: t(".notice")
  #   else
  #     flash.now[:alert] = t(".alert")
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  def destroy
    comment = current_user.comments.find(params[:id])
    spot_id = comment.spot.id
    comment.destroy!
    redirect_to spot_path(spot_id), data: { turbo: false }, notice: t(".notice")
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(spot_id: params[:spot_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
