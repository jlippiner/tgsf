module PagesHelper
  def image_tag_rollover(page)
    val = instance_variable_get("@#{page}_active")
    image_tag("img_nav/#{page}#{'_down' if (val)}.gif")
  end

  def side_nav(text_to_display,nav_item)
    if (params[:action]==nav_item)
      "<td class='nav' id='selected'><span>#{text_to_display}</span></td>"
    else
      link = nav_item if nav_item.starts_with?('http')
      link ||= "page_#{nav_item}".intern
      "<td class='nav'>#{link_to text_to_display, link}</td>"
    end
  end
  
  def header_pic(url=nil)
    @header_url = url
  end
  
  def get_header_pic
    @header_url ? @header_url : 'img_pics/pic_about.jpg'
  end
  
  def hide_right_sidebar
    @hide_right_sidebar = true
  end

end
