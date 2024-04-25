class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    @spot = Spot.find(params[:spot_id])
    set_comments
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @spot = @comment.spot
    @comment.destroy!
    set_comments
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(spot_id: params[:spot_id])
  end

  def set_comments
    @comments = @spot.comments
  end
end
