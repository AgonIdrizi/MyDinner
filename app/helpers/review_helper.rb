module ReviewHelper
  def display_stars(full_stars)
  	empty_stars = 5 - full_stars
  	full_star_html_icon = fa_icon("star",class: "float-right icon-star-full") 
  	empty_star_html_icon = fa_icon("star-o", class: 'float-right icon-star-empty')
  	message =  (empty_star_html_icon * empty_stars) + (full_star_html_icon * full_stars)
  	content_tag(:div, message.html_safe, class: 'stars')
  end
end
