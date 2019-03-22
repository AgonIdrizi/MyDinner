module ReviewHelper
  def display_stars(full_stars)
  	empty_stars = 5 - full_stars unless full_stars == 5
  	full_star_html_icon = fa_icon("star",class: "icon-star-full") 
  	empty_star_html_icon = fa_icon("star-o", class: 'icon-star-empty')
  	message = (full_star_html_icon * full_stars) + (empty_star_html_icon * empty_stars)
  	content_tag(:div, message.html_safe, class: 'stars')
  end
end
