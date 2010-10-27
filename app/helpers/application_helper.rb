module ApplicationHelper

  def title
    base_title = "KeepTrackOfThis.com"
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end
  
end
