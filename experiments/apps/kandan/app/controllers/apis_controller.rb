class ApisController < ApplicationController
  before_filter :authenticate_user!
  
  def active_users
    users = ActiveUsers.all
    respond_to do |format|
      format.json { render :json => users }
    end
  end

  def me
    current_user = current_user
    respond_to do |format|
      format.json { render :json => current_user }
    end
  end
end
