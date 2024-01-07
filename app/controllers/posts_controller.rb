class PostsController < ApplicationController
  before_action :set_post, only: %i[show]

  def show; end

  def new
    @post = Post.new
    @spot = Spot.find(params[:spot_id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to spot_path(@post.spot_id)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body).merge(spot_id: params[:spot_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
