class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @spot = Spot.find(params[:spot_id])
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params.merge(spot_id: params[:spot_id]))
    if @post.save
      redirect_to spot_path(@post.spot_id)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
