require 'rest-client'
require 'json'
require 'pry'

class ReconnectLogin
  def perform(login_id, credentials)
    @login_id = login_id
    @credentials = credentials
    API.request(:put,
      "https://www.saltedge.com/api/v4/logins/#{login_id}/reconnect",
      { 'data' => { 'credentials' => credentials, 'override_credentials' => 'true' }})
  end
end