module BungieReadable

  extend ActiveSupport::Concern

  # Method to hit the bungie API,
  # API key must be stored in the environment under the name "BUNGIE_API_KEY",
  # Every class that includes this module must provide the formatted url (i.e ID included)

  module ClassMethods
    BASE_URL = "http://www.bungie.net/Platform/Destiny/"
    def get_data_from_api(url)
      full_url = BASE_URL + url
      HTTParty.get full_url, headers: { "X-API-KEY" => "57559c5a83f04bb08e874e783022caa3" }
    end
  end

end
