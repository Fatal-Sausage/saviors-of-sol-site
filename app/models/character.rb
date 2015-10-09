class Character
  attr_reader :character_id, :light_level, :base_level, :emblem, :background, :membership_id, :membership_type, :cls, :race, :sex

  @@hashes = {
    '898834093' => 'Exo',
    '3887404748' => 'Human',
    '2803282938' => 'Awoken',
    '3111576190' => 'Male',
    '2204441813' => 'Female',
    '671679327' => 'Hunter',
    '3655393761' => 'Titan',
    '2271682572' => 'Warlock'
  }

  def initialize(character_id, light_level, base_level, emblem, background, membership_id, membership_type, cls, race, sex)
    @character_id = character_id
    @light_level = light_level
    @base_level = base_level
    @emblem = emblem
    @background = background
    @membership_id = membership_id
    @membership_type = membership_type
    @cls = @@hashes[cls.to_s]
    @race = @@hashes[race.to_s]
    @sex = @@hashes[sex.to_s]
  end
end
