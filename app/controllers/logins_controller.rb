require 'tasks/login_tasks'

class LoginsController < ApplicationController
  @@connect_login_service = ConnectLogin.new
  @@save_login_service = SaveLogin.new
  @@reconnect_login_service = ReconnectLogin.new
  @@refresh_login_service = RefreshLogin.new
  @@remove_login_service = RemoveLogin.new

  def create_login  
    connect_url = @@connect_login_service.perform(current_user.id)
    redirect_to connect_url
  end

  def save_login
    @@save_login_service.perform(current_user.id)
  end

  def callback_success
    save_login
    redirect_to dashboard_path
  end

  def index
    @logins = current_user.logins
  end

  def show
    @login = Login.find(params[:id])
    @accounts = @login.accounts
  end

  def list
    user_logins = Tasks::LoginTasks.new.list_logins(current_user.id)
    render json: user_logins
  end

  def reconnect_login
    credentials = {
      'login' => params[:login],
      'password' => params[:password]
    }
    response = @@reconnect_login_service.perform(params[:login_id], credentials)
    render json: response
  end

  def login_credentials
  end

  def refresh_login
    response = @@refresh_login_service.perform(params[:login_id])
    render json: response
  end

  def remove_login
    @@remove_login_service.perform(params[:login_id])
    Login.find_by(login_id: params[:login_id]).destroy
    redirect_to logins_path
  end
end
