require 'spec_helper'

describe ManagementController do
  describe "Managment Seite" do
    it "HTTP Should not be ok when not logged in" do
      get 'management'
      response.should_not be_success
    end
    it "HTTP Should not be ok when logged in as user" do
      user = FactoryGirl.create(:user)
      sign_in user
      get 'management'
      response.should_not be_success
    end 
    it "HTTP Should be ok when logged in as admin" do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      get 'management'
      response.should be_success
    end
  end
end
