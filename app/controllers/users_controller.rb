class UsersController < ApplicationController
  def index
    @users = User.all
    #@unapproved_users = User.find_all_by_approved(false)
  end
end
