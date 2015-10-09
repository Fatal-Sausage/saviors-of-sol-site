require 'uri'

class Player
  include BungieReadable

  attr_reader :icon_path, :membership_id, :membership_type, :display_name, :characters

  def initialize(icon_path, membership_id, membership_type, display_name)
    @icon_path = icon_path
    @membership_id = membership_id
    @membership_type = membership_type
    @display_name = display_name
    @characters = getchars
  end

  def getchars
    url = "#{@membership_type}/Account/#{@membership_id}"
    data = get_data_from_api(url)
    characters = {}
    img_base = "http://www.bungie.net/"
    data["Response"]["data"]["characters"].each do |char|
      character_id = char["characterBase"]["characterId"]
      light_level = char["characterBase"]["powerLevel"]
      base_level = char["baseCharacterLevel"]
      emblem = img_base + char["emblemPath"]
      background = img_base + char["backgroundPath"]
      race_hash = char["characterBase"]["raceHash"]
      sex_hash = char["characterBase"]["genderHash"]
      class_hash = char["characterBase"]["classHash"]
      char_data = [character_id, light_level, base_level, emblem, background, race_hash, sex_hash, class_hash]
      characters[character_id.to_sym] = Character.new(character_id, light_level, base_level, emblem, background, @membership_id, @membership_type, class_hash, race_hash, sex_hash)
    end
    characters
  end

end
