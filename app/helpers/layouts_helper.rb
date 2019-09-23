module LayoutsHelper
  def restaurant_name
   params[:name].nil? ? 'My dinner' : params[:name].split('-').join(' ')
  end
end
