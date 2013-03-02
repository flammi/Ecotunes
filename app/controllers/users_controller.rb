class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def remove_user
    id = params[:user_id]
    if id != nil
      user = User.find_by_id(id)
    end
    if user != nil and user.destroy
      render :json => { }
    else
      render :json => { }, :status => 500
    end
  end

  def upgrade_user
    id = params[:user_id]
    if id != nil
      user = User.find_by_id(id)
    end
    if user
      if user.has_role?(:user)
        user.add_role :admin
      else
        user.add_role :user
      end
      if user.save
        render :json => { }
      else
        render :json => { }, :status => 500
      end
    else
      render :json => { }, :status => 500
    end
  end

  def downgrade_user
    id = params[:user_id]
    if id != nil
      user = User.find_by_id(id)
    end
    if user and user.has_role?(:admin)
      user.remove_role :admin
      user.add_role :user
      if user.save
        render :json => { }
      else
        render :json => { }, :status => 500
      end
    else
      render :json => { }, :status => 500
    end
  end

  def activate_user
    id = params[:user_id]
    if id != nil
      user = User.find_by_id(id)
    end
    if user
      user.approved = true
      if user.save
        render :json => { }
      else
        render :json => { }, :status => 500
      end
    else
      render :json => { }, :status => 500
    end
  end

  def deactivate_user
    id = params[:user_id]
    if id != nil
      user = User.find_by_id(id)
    end
    if user
      user.approved = false
      if user.save
        render :json => { }
      else
        render :json => { }, :status => 500
      end
    else
      render :json => { }, :status => 500
    end
  end
end
