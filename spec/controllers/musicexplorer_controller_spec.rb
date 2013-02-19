require 'spec_helper'

describe MusicexplorerController do

  describe "GET 'explorer'" do
    it "returns http success" do
      get 'explorer'
      response.should be_success
    end
  end

end
