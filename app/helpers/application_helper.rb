module ApplicationHelper
  def page_section(name)
    url = Rails.env == 'production' ? "'/spages/#{ name }.html" : '/pages/' + name
    "<section id=\"#{ name }\" class=\"container\" src=\"#{ url }\"></section>".html_safe
  end
end
