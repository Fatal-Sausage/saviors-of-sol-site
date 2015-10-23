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
    
    signin_url = 'https://www.bungie.net/en/User/SignIn/Xuid?bru=%252f'
    # signin_result = HTTParty.get signin_url
    signin_result = Net::HTTP.get_response(URI(signin_url))
    alt_signin_result = RestClient.get signin_url
    new_signin_result = Net::HTTP.get_response(URI(signin_result.body[/href=\"(.*?)\"/,1]))
    # debugger
    ppft = alt_signin_result.to_str[/value=\"(.*?)\"\/>/,1]
    # post_url = signin_result.body[/redirect_uri=(.*?)\"/,1]
    post_url = signin_result.body[/href=\"(.*?)\"/,1]
    payload = { 'login' => email, 'passwd' => password, 'PPFT' => ppft }
    cookies = get_cookies_from_string(signin_result.header["set-cookie"])
    api_headers = {'X-API-Key' => ENV["BUNGIE_API_KEY"], "x-csrf" => cookies['bungled']}
    result = HTTParty.post(post_url, data: payload)
    begin
      alt_result = RestClient.post(post_url, payload)
    rescue RestClient::Exception => e
      alt_result = e
    end
    final_test = HTTParty.get("https://www.bungie.net/Platform/Destiny/1/MyAccount/Vault/" , header: api_headers)
    alt_final_test = RestClient.get("https://www.bungie.net/Platform/Destiny/1/MyAccount/Vault/", api_headers)
    debugger
  end

  # Alternate Attempt

=begin
    # Replace with cookie session store
    cookie_hash = {}

    # Keep track of the differences between xbox and playstation signins
    method_hash = {
      psn: "Psnid",
      xbox: "Xuid"
    }

    if method_hash[method]
      dest = method_hash[method]
    else
      dest = "Wlid"
    end

    url = "https://www.bungie.net/en/User/Signin/#{dest}"
    # uri = URI("https://www.bungie.net/en/User/Signin/#{dest}")
    response = HTTParty.get(url)
    # response = Net::HTTP.get_response(uri)
    cookie = get_cookies_from_string(response.response["set-cookie"])
    # debugger
    # cookie_hash[:bungie_sign_in] = response.response["set-cookie"]

    # Save redirect url
    redirect_url = response.request.last_uri.to_s

    # Return true because the bungie cookie is still valid from last successful sign in
    return true if !redirect_url

    # Try to authenticate with the third party
    # cookie: cookie_hash[:bungie_sign_in]

    auth_result = HTTParty.get(redirect_url, cookie: cookie)
    # auth_result = Net::HTTP.get_response(URI(redirect_url))
    auth_url = auth_result.request.last_uri.to_s

    # debugger

    # Normally authentication will produce a 302 Redirect, but Xbox is special...
    auth_url = auth_result.request.path.to_s if auth_result.response.code == 200

    # No valid cookies
    unless auth_url.index("#{url}?code")
      result = false
      case method
      when :psn
        login_url = "https://auth.api.sonyentertainmentnetwork.com/login.do"

        # login to PSN

        payload = {
          params: 'cmVxdWVzdF9sb2NhbGU9ZW5fVVMmcmVxdWVzdF90aGVtZT1saXF1aWQ=', # without empty server result 
          j_username: email,
          j_password: password,
          rememberSignIn: 1 # Remember signin
        }

        login_response = HTTParty.post(login_url, body: payload)
        login_redirect_url = login_response.request.last_uri.to_s

        # False if we get an authentication error in the redirect_url
        return :authentication_error if redirect_url.index("authentication_error") # TODO: Change back to false
 
        # Authenticate with Bungie
        result = HTTParty.get(redirect_url)

      when :xbox
        login_url = "https://login.live.com/ppsecure/post.srf?#{redirect_url[(redirect_url.index("?") + 1)..-1]}"
        ppft = auth_result[/value=\"(.*?)\"\/>/,1]

        if (ppft)
          payload = {
            "login" => email,
            "passwd" => password,
            "KMSI" => 1, # Stay signed in
            "PPFT" => ppft
          }

          result = HTTParty.post(login_url, payload)
          auth_url = result.request.path.to_s

          return true if auth_url.index("#{url}?code")
          debugger
        end
        return :xbox_case # TODO: return false
      end

      result_url = result.request.path.to_s
      result_url = result.request.last_uri.to_s if result.response.code == 302

      # Account has not been registered with Bungie
      return :registration if result_url.index("/Register") # TODO: return false
       
      # If loggin successful, "bungleatk" should be set
      # Facebook/PSN should return with ?code=
      # Xbox should have ?wa=wsignin1.0
      return result_url.index(url) != nil
    end

    # Valid third party cookies, re-authenticating Bungie login
    HTTParty.get(auth_url)
    return true
  end
=end

end
