require 'tasks/login_tasks'

class LoginsController < ApplicationController
  def create_login
    connect_url = ConnectLogin.new(current_user.id).perform
    redirect_to connect_url
  end

  def save_login
    save_login_service = SaveLogin.new(current_user.id)
    save_login_service.perform  
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
      'password' => params[:password]}
      reconnect_login_service = ReconnectLogin.new(params[:login_id], credentials)
      response = reconnect_login_service.perform
    render json: response
  end

  def login_credentials
    login_id = params[:login_id]
  end

  def refresh_login
    refresh_login_service = RefreshLogin.new(params[:login_id])
    response = refresh_login_service.perform
    render json: response
  end

  def remove_login
    remove_login_service = RemoveLogin.new(params[:login_id])
    response = remove_login_service.perform
    Login.find_by(login_id: params[:login_id]).destroy
    redirect_to logins_path
  end

end
