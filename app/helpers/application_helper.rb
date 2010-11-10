module ApplicationHelper

  def title
    base_title = "KeepTrackOfThis.com"
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end

  def logo
    image_tag("logo.jpg", :alt => "Sample App", :class => "round")
  end

end
