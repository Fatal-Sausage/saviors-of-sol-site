module BungieReadable

  extend ActiveSupport::Concern
  BASE_URL = "http://www.bungie.net/Platform/Destiny/"
  # Method to hit the bungie API,
  # API key must be stored in the environment under the name "BUNGIE_API_KEY",
  # Every class that includes this module must provide the formatted url (i.e ID included)
  def get_data_from_api(url)
    full_url = BASE_URL + url
    HTTParty.get full_url, headers: { "X-API-KEY" => ENV["BUNGIE_API_KEY"] }
  end

  module ClassMethods

    def get_data_from_api(url)
      full_url = BASE_URL + url
      HTTParty.get full_url, headers: { "X-API-KEY" => ENV["BUNGIE_API_KEY"] }
    end
  end

end
