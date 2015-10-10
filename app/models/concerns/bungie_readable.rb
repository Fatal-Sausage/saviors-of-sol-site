require 'uri'

module BungieReadable

  extend ActiveSupport::Concern

  BASE_URL = "https://www.bungie.net/Platform/Destiny/"

  # Method to hit the bungie API,
  # API key must be stored in the environment under the name "BUNGIE_API_KEY",
  # Every class that includes this module must provide the formatted url (i.e ID included)
  def get_data_from_api(url)
    HTTParty.get url, headers: { "X-API-KEY" => ENV["BUNGIE_API_KEY"] }
  end

  module ClassMethods

    def get_data_from_api(url)
      HTTParty.get url, headers: { "X-API-KEY" => ENV["BUNGIE_API_KEY"] }
    end

    # Class method to format url.
    # We use an array as args for flexibility.
    # ie Player.format_url(1234,"Account",5678) => "http://www.bungie.net/Platform/Destiny/1234/Account/5678"
    def format_url(*args)
      URI.escape(BASE_URL + args.join("/"));
    end
  end

end
