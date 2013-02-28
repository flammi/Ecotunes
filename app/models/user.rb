class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  after_create :set_default_role

  def set_default_role
    if Preferences.DEFAULT_ADMIN
      self.add_role :admin
    else
      self.add_role :user
    end
  end

  def highest_role
    if self.has_role?(:admin)
      return "Administrator"
    elsif self.has_role?(:user)
      return "Benutzer"
    else
      "Keine Nutzerrolle"
    end
  end

  def active_for_authentication? 
    if !Preferences.REQUIRE_UNLOCK
      super
    else
      super && approved?
    end
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
end
