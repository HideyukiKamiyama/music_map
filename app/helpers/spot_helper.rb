module SpotHelper
  def render_bookmark_button(user, spot)
    if user.bookmark?(spot)
      render 'unbookmark', { spot: spot }
    else
      render 'bookmark', { spot: spot }
    end
  end
end
