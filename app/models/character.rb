require 'uri'

class Character
  include BungieReadable

  @@character_url = "https://www.bungie.net/platform/destiny/"# {membershiptype}/account/{destinymembershipid}/character/{characterid}"
  
  attr_reader :minutes_played_total, :power_level

  def initialize(membership_type, membership_id, character_id)
    @membership_type = membership_type
    @membership_id = membership_id
    @character_id = character_id
    load_character
  end

  def format_url
    URI.escape(@@character_url + "#{@membership_type}/account/#{@membership_id}/character/#{@character_id}/")
  end

  def load_character
    # debugger
    data = get_data_from_api(format_url)
    character_data = data["Response"]["data"]
    @minutes_played_total = character_data["characterBase"]["minutesPlayedTotal"]
    @power_level = character_data["characterBase"]["powerLevel"] 
  end

end