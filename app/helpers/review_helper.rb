module ReviewHelper
  def display_stars(full_stars)
    full_stars = 0 if full_stars.nil? 
  	empty_stars = 5 - full_stars
  	full_star_html_icon = fa_icon("star",class: "float-right icon-star-full") 
  	empty_star_html_icon = fa_icon("star-o", class: 'float-right icon-star-empty')
  	message =  (empty_star_html_icon * empty_stars) + (full_star_html_icon * full_stars)
  	content_tag(:div, message.html_safe, class: 'stars')
  end

  def is_your_review?(review)
    return false if !current_user.present?
  	current_user.id == review.user_id
  end
end
