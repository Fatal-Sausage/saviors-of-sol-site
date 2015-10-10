class Player
  include BungieReadable

  attr_reader :icon_path, :membership_id, :membership_type, :display_name, :characters

  def initialize(attributes = {})
    @icon_path = attributes[:icon_path]
    @membership_id = attributes[:membership_id]
    @membership_type = attributes[:membership_type]
    @display_name = attributes[:display_name]
    @characters = characters
  end

  def img_base
    "http://www.bungie.net/"
  end

  # Method named characters for easier readablity
  # i.e Player.first.characters => array of characters
  def characters
    data = get_data_from_api Player.format_url(@membership_type, "Account", @membership_id)
    data["Response"]["data"]["characters"].map do |character|
      Character.new({
        character_id: character["characterBase"]["characterId"],
        light_level: character["characterBase"]["powerLevel"],
        base_level: character["baseCharacterLevel"],
        emblem: (img_base + character["emblemPath"]),
        background: (img_base + character["backgroundPath"]),
        race: character["characterBase"]["raceHash"],
        sex: character["characterBase"]["genderHash"],
        cls: character["characterBase"]["classHash"],
        membership_id: @membership_id,
        membership_type: @membership_type
      })
    end
  end

end
