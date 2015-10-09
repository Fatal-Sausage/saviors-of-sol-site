require 'uri'

class User < ActiveRecord::Base
  include BungieReadable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end

  @@user_url = "https://www.bungie.net/platform/User/GetBungieAccount/" #membershipID/type/""

  def load_user
    user_data = get_data_from_api(format_url)
  end

  def characters
    # debugger
    load_user["Response"]["destinyAccounts"].map do |account|
      account["characters"].map do |character|
        Character.new(account["userInfo"]["membershipType"], account["userInfo"]["membershipId"], character["characterId"])
      end
    end.flatten
  end

  def format_url
    URI.escape(@@user_url + "#{membership_id}/#{membership_type}/")
  end
end
