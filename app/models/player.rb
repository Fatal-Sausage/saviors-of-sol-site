require 'uri'

class Player
  include BungieReadable

  @@player_search_url = "https://www.bungie.net/platform/User/SearchUsersPaged/" #searchTerm/page/
  @@player_show_url = "https://www.bungie.net/platform/User/GetBungieAccount/" #membershipID/type/

  def self.format_search_url(search_term, page)
    URI.escape(@@player_search_url + "#{search_term}/#{page}/")
  end

  def self.format_show_url(membershipId, membershipType)
    URI.escape(@@player_show_url + "#{membershipId}/#{membershipType}/")
  end

  def self.search_players(search_term, page)
    data = get_data_from_api(format_search_url(search_term, page))
    data["Response"]["results"]
  end

  def self.show_player(membership_id, membershipType = 254)
    data = get_data_from_api(format_show_url(membership_id, membershipType))
    data["Response"]
  end

end