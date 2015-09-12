class SessionsController < ApplicationController

  def create
    params[:email]
    params[:password]
  end

  def new
  end
end
