class Character
  attr_reader :character_id, :light_level, :base_level, :emblem, :background, :membership_id, :membership_type, :cls, :race, :sex
  def initialize(character_id, light_level, base_level, emblem, background, membership_id, membership_type, cls, race, sex)
    @character_id = character_id
    @light_level = light_level
    @base_level = base_level
    @emblem = emblem
    @background = background
    @membership_id = membership_id
    @membership_type = membership_type
    @cls = cls
    @race = race
    @sex = sex
  end
end
