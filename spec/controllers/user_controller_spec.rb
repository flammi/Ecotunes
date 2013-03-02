require 'spec_helper'

describe UsersController do

  describe "User Seite" do
    it "HTTP Should not be ok when not logged in" do
      get 'index'
      response.should_not be_success
    end
    it "HTTP Should not be ok when logged in as user" do
      user = FactoryGirl.create(:user)
      sign_in user
      get 'index'
      response.should_not be_success
    end 
    it "HTTP Should be ok when logged in as admin" do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      get 'index'
      response.should be_success
    end
  end

end
