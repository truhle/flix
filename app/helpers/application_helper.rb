module ApplicationHelper

  def page_title
    if content_for?(:title)
      content_tag(:title, "Flix - #{content_for(:title)}")
    else
      content_tag(:title, "Flix")
    end
  end

  def title(title)
    content_for(:title, title)
  end

  def nav_link_to(name, path)
    if current_page?(path)
      link_to name, path, class: 'button active'
    else
      link_to name, path, class: 'button'
    end
  end
end
