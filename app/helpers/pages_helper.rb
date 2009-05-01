module PagesHelper
  def image_tag_rollover(page)
    val = instance_variable_get("@#{page}_active")
    image_tag("img_nav/#{page}#{'_down' if (val)}.gif")
  end
end
