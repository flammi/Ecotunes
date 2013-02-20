require 'spec_helper'

describe PlaylistGeneratorController do

  describe "GET 'Playlist'" do
    it "returns http success" do
      get 'Playlist'
      response.should be_success
    end
  end

end
