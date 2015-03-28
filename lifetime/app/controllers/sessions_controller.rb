class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    render :text => auth_hash.inspect
    #reorder auth_hash to crete user if new user
    
  end

  def failure
  end

  def destroy
  end
end
