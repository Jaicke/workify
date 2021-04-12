module NavigationHelper
  def nav_link_to(body, url, controller_name, icon = nil, html_options = {})
      active = "active" if current_section?(controller_name)
      content_tag :li, class: [active, 'nav-item', 'item'] do
        link_to url, html_options.merge(class: 'nav-link menu-btn') do
          "#{content_tag(:span, '', class: "fa fa-#{icon}")} #{body}".html_safe
        end
      end
    end

    def nav_dropdown_item(body, url, icon, html_options = {})
      link_to url, html_options.merge(class: 'dropdown-item') do
        "#{content_tag(:span, '', class: "fa fa-#{icon}")} #{body}".html_safe
      end
    end

    def current_section?(section)
      if section.is_a? Array
        section.each do |s|
          return true if request.path.split('/').include?(s)
        end
      else
        request.path.split('/').include?(section)
      end
  end
end
