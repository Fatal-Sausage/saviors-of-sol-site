class Character
  
  attr_reader :character_id, :light_level, :base_level, :emblem, :background, :membership_id, :membership_type, :cls, :race, :sex

  @@type_hashes = {
    '898834093' => 'Exo',
    '3887404748' => 'Human',
    '2803282938' => 'Awoken',
    '3111576190' => 'Male',
    '2204441813' => 'Female',
    '671679327' => 'Hunter',
    '3655393761' => 'Titan',
    '2271682572' => 'Warlock'
  }

  # Initialize takes a hash so we can pass the values we want to save in any order we want.
  # i.e Character.new(light_level: 34, background: "/img/bground.png", race: "Male")
  def initialize(attributes = {})
    @character_id = attributes[:character_id]
    @light_level = attributes[:light_level]
    @base_level = attributes[:base_level]
    @emblem = attributes[:emblem]
    @background = attributes[:background]
    @membership_id = attributes[:membership_id]
    @membership_type = attributes[:membership_type]
    @cls = @@type_hashes[attributes[:cls].to_s]
    @race = @@type_hashes[attributes[:race].to_s]
    @sex = @@type_hashes[attributes[:sex].to_s]
  end
end
