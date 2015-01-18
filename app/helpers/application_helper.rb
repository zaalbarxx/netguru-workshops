module ApplicationHelper
  def redirect_if_not_admin
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end

  def user_is_admin?(user)
    user and user.admin?
  end

  def full_title(page_title = '')
    base_title = "Netguru Workshops"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
