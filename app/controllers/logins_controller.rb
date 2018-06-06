require 'tasks/login_tasks'

class LoginsController < ApplicationController
  def create_login
    connect_url = Tasks::LoginTasks.new.perform(current_user.id)
    redirect_to connect_url
  end

  def save_login
    Tasks::LoginTasks.new.save(current_user.id)
    redirect_to dashboard_path
  end

  def index
    @logins = current_user.logins
  end

  def list
    user_logins = Tasks::LoginTasks.new.list_logins(current_user.id)
    render json: user_logins
  end

  def reconnect_login
    credentials = {
      'login' => params[:login], 
      'password' => params[:password]}
    response = Tasks::LoginTasks.new.reconnect(params[:login_id], credentials)
    render json: response
  end

  def login_credentials
    login_id = params[:login_id]
  end

  def refresh_login
    response = Tasks::LoginTasks.new.refresh(params[:login_id])
    render json: response
  end

  def remove_login
    response = Tasks::LoginTasks.new.remove(params[:login_id])
    Login.find_by(login_id: params[:login_id]).destroy
    redirect_to logins_path
  end

end
