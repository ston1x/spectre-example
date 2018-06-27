require 'rest-client'
require 'json'

class RefreshLogin
  def perform(login_id)
    @login_id = login_id
    API.request(:put, "https://www.saltedge.com/api/v4/logins/#{@login_id}/refresh")
  end
end