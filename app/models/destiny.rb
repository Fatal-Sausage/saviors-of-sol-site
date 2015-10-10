class Destiny
  include BungieReadable

  @@search_url = "SearchDestinyPlayer"

  def self.search_for_player(platform, gamertag)
    data = get_data_from_api format_url(@@search_url, platform, gamertag)
    player = Player.new({
      icon_path: data["Response"][0]["iconPath"],
      membership_id: data["Response"][0]["membershipId"],
      membership_type: data["Response"][0]["membershipType"],
      display_name: data["Response"][0]["displayName"]
    })
  end
end
