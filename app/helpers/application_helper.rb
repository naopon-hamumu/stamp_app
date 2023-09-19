module ApplicationHelper
  def bootstrap_class_for_flash(type)
    case type
    when 'notice' then "info"
    when 'success' then "success"
    when 'error' then "danger"
    when 'alert' then "warning"
    else type.to_s
    end
  end

  def page_title(page_title = '')
    base_title = 'Stamp Bon Voyage'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
