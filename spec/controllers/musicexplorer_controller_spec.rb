require 'spec_helper'

describe MusicexplorerController do

  describe "Tests der Musikdatenbank (Hauptseite)" do
    it "HTTP Success Return Code wenn eingeloggt" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create :user
      sign_in user
      get 'explorer'
      response.should be_success
    end
    it "Failure, wenn nicht eingeloogt" do
      get 'explorer'
      response.should_not be_success
    end 
  end

end
