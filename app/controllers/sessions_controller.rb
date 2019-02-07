class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    redirect_to user_path(user)
  end

  def destroy
    params[:authenticity_token] = nil
    redirect_to login_path
  end
end
