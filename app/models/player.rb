require 'uri'

class Player
  include BungieReadable

  attr_reader :icon_path, :membership_id, :membership_type, :display_name, :characters

  def initialize(icon_path, membership_id, membership_type, display_name)
    @icon_path = icon_path
    @membership_id = membership_id
    @membership_type = membership_type
    @display_name = display_name
    getchars
  end

  def getchars
    url = "#{@membership_type}/Account/#{membership_id}"
    #full_url = URI.escape("http://bungie.net/Platform/Destiny/#{url}")
    #data = HTTParty.get full_url, headers: { "X-API-KEY" => "57559c5a83f04bb08e874e783022caa3" }
    data = get_data_from_api(url)
    @characters = data
  end

end
