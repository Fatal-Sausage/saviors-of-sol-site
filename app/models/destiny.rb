require 'net/http'
require 'rest-client'

class Destiny
  include BungieReadable

  @@search_url = "SearchDestinyPlayer"

  def self.search_for_player(platform, gamertag)
    data = get_data_from_api format_url(@@search_url, platform, gamertag)
    player = Player.new({
      icon_path: data["Response"][0]["iconPath"],
      membership_id: data["Response"][0]["membershipId"],
      membership_type: data["Response"][0]["membershipType"],
      display_name: data["Response"][0]["displayName"]
    })
  end

  def self.auth(email, password, method = :xbox)

    # Just XBOX Attempt

    # The xbox sign_in url
    signin_url = 'https://www.bungie.net/en/User/SignIn/Xuid?bru=%252f'

    # GET the signin_url
    signin_result = Net::HTTP.get_response(URI(signin_url))

    # Follow the redirection
    new_signin_result = Net::HTTP.get_response(URI(signin_result.response["location"]))

    # Get the ppft from the response body
    ppft = new_signin_result.body[/value=\"(.*?)\"\/>/,1]

    # Get the post_url from the response body
    post_url = signin_result.body[/href=\"(.*?)\"/,1]

    # Format our post payload
    payload = {
      'login' => email,
      'passwd' => password,
      'PPFT' => ppft,
      'response_type' => "json"
    }

    # Format all of our cookies
    cookies = get_cookies_from_string(signin_result.header["set-cookie"])

    # Set the headers to be used when accessing the user's vault
    api_headers = { 'X-API-Key' => ENV["BUNGIE_API_KEY"], "x-csrf" => cookies['bungled'] }

    # Make the POST request with the info we have
    post_uri = URI(post_url)
    req = Net::HTTP::Post.new(post_uri.path)
    req.set_form_data(payload)

    res = Net::HTTP.start(post_uri.hostname, post_uri.port, use_ssl: post_uri.scheme == 'https') { |http| http.request(req) }

    # Format the uri for the user vault
    vault_uri = URI("https://www.bungie.net/Platform/Destiny/1/MyAccount/Vault/")
    vault_uri.query = URI.encode_www_form(api_headers)

    # Attempt to access the user vault
    vault_access = Net::HTTP.get_response(URI(vault_uri))

    # This is as far as we get, uncomment line 68 to get an interactive look at this method
    # debugger
    # The interesting part of this problem can be found by running this command in the debugging console:
    # res.response["location"]
    # Bungie complains that we don't have a client ID in the request, I'm not sure how to go about getting one
  end

end
