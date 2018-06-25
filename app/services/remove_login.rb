require 'rest-client'
require 'json'

class RemoveLogin
  attr_accessor :login_id
  def initialize(login_id)
    @login_id = login_id
  end
  
  def perform
    API.request(:delete, "https://www.saltedge.com/api/v4/logins/#{@login_id}")
  end
end