class SessionsController < ApplicationController

  def create
    if user = User.authenticate(params[:username_or_email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to(session[:intended_url] || user)
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Invalid username/email and password combination."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have signed out!"
  end

  def new
  end
end
