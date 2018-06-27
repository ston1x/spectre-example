require 'rest-client'
require 'json'
require 'pry'

class SaveLogin
  def initialize(user_id)
    @user = User.find(user_id)
  end

  def perform
    user_logins = list_logins(@user.id)
    login = Login.new(
      user_id: @user.id,
      login_id: user_logins['data'].last['id'],
      country_code: user_logins['data'].last['country_code'],
      created_time: user_logins['data'].last['created_at'],
      status: user_logins['data'].last['status']
      )
    login.save
  end

  def list_logins(user_id)
    user_logins = API.request(:get, 'https://www.saltedge.com/api/v4/logins/',
      { 'data' => { 'customer_id' => @user.customer_id }})
    JSON.parse user_logins.body
  end
end
