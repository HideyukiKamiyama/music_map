module SpotHelper
  def render_bookmark_button(user, spot)
    if user.bookmark?(spot)
      render 'unbookmark', { spot: }
    else
      render 'bookmark', { spot: }
    end
  end
end
