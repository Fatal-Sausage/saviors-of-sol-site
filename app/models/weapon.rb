class Weapon < ActiveRecord::Base

  # We are taking some methods from this module
  # It's defined in app/modes/concerns/bungie_readable.rb
  extend BungieReadable

  # This allows us to access a weapons attributes
  #eq. weapon.name => "Gdallarhorn"
  attr_reader :name, :description, :rarity, :type

  # Class variable to save the API endppoint for returning weapon data
  @@request_url = "https://www.bungie.net/platform/Destiny/Manifest/InventoryItem/"

  # This is a method to add the id to the url for making specific requests
  def self.format_url(bungie_item_id)
    @@request_url + "#{bungie_item_id}/"
  end

  # This is a debugging method in case any contributers want to see sample output.
  # In the rails console (type `rails c` into the command prompt) enter Weapon.sample_bungie_response
  # It will return the bungie data for Gdallarhorn
  def self.sample_bungie_response
    get_data_from_api(format_url(1274330687))
  end

  # This method will attempt to retrieve an item from our database
  # If it cannot find the record in our database, it will go to the bungie API,
  # then create a record in our database so we don't have to make another request to view
  # it again
  def self.find_or_create_from_api(bungie_item_id)
    if found_record = find_by(bungie_id: bungie_item_id)
      found_record
    else
      bungie_data = get_data_from_api(format_url(bungie_item_id))
      create_from_api(bungie_data)
    end
  end

  # Used by find_or_create_from_api to create a new weapon record in the DB based on the information we want to save.
  # The info specified so far is just the basics, we will be adding more rows when we decide want we want from the db.
  def self.create_from_api(bungie_data)
    create({
      name: bungie_data["Response"]["data"]["inventoryItem"]["itemName"],
      description: bungie_data["Response"]["data"]["inventoryItem"]["itemDescription"],
      rarity: bungie_data["Response"]["data"]["inventoryItem"]["tierTypeName"],
      weapon_type: bungie_data["Response"]["data"]["inventoryItem"]["itemTypeName"],
      bungie_id: bungie_data["Response"]["data"]["requestedId"]
    })
  end

end