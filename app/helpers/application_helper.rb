module ApplicationHelper
  def page_section(name)
    url = '/pages/' + name
    "<section id=\"#{ name }\" class=\"container-fluid\" src=\"#{ url }\"></section>".html_safe
  end
end
