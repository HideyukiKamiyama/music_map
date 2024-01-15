class CommentsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_comment, only: %i[edit update]

  def index
    @comments = Comment.order(updated_at: "DESC").page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
    @spot = Spot.find(params[:spot_id])
  end

  def edit; end

  def create
    @comment = current_user.comments.build(comment_params.merge(spot_id: params[:spot_id]))
    if @comment.save
      redirect_to spot_path(@comment.spot_id), data: { turbo: false }, notice: t(".notice")
    else
      flash.now[:alert] = t(".alert")
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_path(@comment), notice: t(".notice")
    else
      flash.now[:alert] = t(".alert")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    spot_id = comment.spot.id
    comment.destroy!
    redirect_to spot_path(spot_id), data: { turbo: false }, notice: t(".notice")
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
