require 'uri'

class Destiny
  include BungieReadable

  SEARCH_URL = "SearchDestinyPlayer/"

  def self.search_for_player(platform, gamertag)
    url = URI.escape(SEARCH_URL + "#{platform}/#{gamertag}")
    data = get_data_from_api(url)
    response = data["Response"]
    player = Player.new(response["iconPath"], response["membershipId"], response["membershipType"], response["displayName"])
    player
  end
end
