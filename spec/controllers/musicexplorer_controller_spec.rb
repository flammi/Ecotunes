require 'spec_helper'

describe MusicexplorerController do

  describe "Tests der Musikdatenbank" do
    it "http success" do
      get 'explorer'
      response.should be_success
    end
  end

end
