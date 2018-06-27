require 'tasks/login_tasks'

class LoginsController < ApplicationController
  def create_login
    connect_url = connect_login_service.perform(current_user.id)
    redirect_to connect_url
  end

  def save_login
    save_login_service.perform(current_user.id)
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
    response = reconnect_login_service.perform(params[:login_id], credentials)
    if response['error_message']
      flash[:alert] = response['error_message']
    else
      flash[:notice] = 'Login successfully reconnected'
    end
    redirect_to logins_path
  end

  def login_credentials
  end

  def refresh_login
    response = refresh_login_service.perform(params[:login_id])
    next_refresh = response['next_refresh_possible_at']
    if response['error_message']
      flash[:alert] = "#{response['error_message']} Next refresh possible at: #{next_refresh}"
    else
      flash[:notice] = 'Login successfully refreshed'
    end
    redirect_to logins_path
  end

  def remove_login
    remove_login_service.perform(params[:login_id])
    Login.find_by(login_id: params[:login_id]).destroy
    redirect_to logins_path
  end

  # Memoize service objects
  def connect_login_service
    @connect_login_service ||= ConnectLogin.new
  end

  def save_login_service
    @save_login_service ||= SaveLogin.new
  end

  def reconnect_login_service
    @reconnect_login_service ||= ReconnectLogin.new
  end

  def refresh_login_service
    @refresh_login_service ||= RefreshLogin.new
  end

  def remove_login_service
    @remove_login_service ||= RemoveLogin.new
  end
end
