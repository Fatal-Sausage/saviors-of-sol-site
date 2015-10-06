class Weapon < ActiveRecord::Base
  extend BungieReadable

  attr_reader :name, :description, :rarity, :type

  # Class variable to save the API endppoint for returning weapon data
  @@request_url = "https://www.bungie.net/platform/Destiny/Manifest/InventoryItem/"

  def self.format_url(bungie_item_id)
    @@request_url + "#{bungie_item_id}/"
  end

  def self.sample_bungie_response
    get_data_from_api(format_url(1274330687))
  end

  def self.find_or_create_from_api(bungie_item_id)
    if found_record = find_by(bungie_id: bungie_item_id)
      found_record
    else
      bungie_data = get_data_from_api(format_url(bungie_item_id))
      create_from_api(bungie_data)
    end
  end

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