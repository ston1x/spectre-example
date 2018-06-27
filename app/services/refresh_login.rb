require 'rest-client'
require 'json'

class RefreshLogin
  attr_accessor :login_id
  def initialize(login_id)
    @login_id = login_id
  end
  
  def perform
    API.request(:put, "https://www.saltedge.com/api/v4/logins/#{@login_id}/refresh")
  end
end