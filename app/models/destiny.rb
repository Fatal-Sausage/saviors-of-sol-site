require 'uri'

class Destiny
  include BungieReadable

  SEARCH_URL = "SearchDestinyPlayer/"

  def self.search_for_player(platform, gamertag)
    url = URI.escape(SEARCH_URL + "#{platform}/#{gamertag}")
    data = get_data_from_api(url)
    player = Player.new(data["Response"][0]["iconPath"], data["Response"][0]["membershipId"], data["Response"][0]["membershipType"],data["Response"][0]["displayName"])
    player
  end
end
