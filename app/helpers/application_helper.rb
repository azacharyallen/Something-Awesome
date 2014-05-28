module ApplicationHelper
  def full_title(page_title)
    base_title = "The Something Awesome Forums"
    page_title.empty? ?  base_title : "#{page_title} - #{base_title}"
 end
end
