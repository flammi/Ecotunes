require 'spec_helper'
require 'songs_helper'
# Specs in this file have access to a helper object that includes
# the SongsHelper. For example:
#
# describe SongsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end

describe SongsHelper do
  before do
    collins_path = Rails.root.join('spec', 'helpers', 'collins.mp3').to_s # file to check
    eminem_path = Rails.root.join('spec', 'helpers', 'eminem.mp3').to_s

    @duration1, @fingerprint1 = helper.fingerprint_and_duration collins_path
    @duration2, @fingerprint2 = helper.fingerprint_and_duration collins_path
    
    @duration3, @fingerprint3 = helper.fingerprint_and_duration eminem_path
  end

  describe "check fingerprint two times" do
    it "should have the same fingerprint" do
      @duration1.should eq(@duration2)
      @fingerprint1.should eq(@fingerprint2)
    end
  end

  describe "check the fingerprint of two different songs" do
    it "should not have the same fingerprint" do
      @duration1.should_not eq(@duration3)
      @fingerprint1.should_not eq(@fingerprint3)
    end
  end

  describe "check if connection to last.fm exists" do
    it "shouldn't return an error" do
      expect {helper.get_album_info "Eminem", "Recovery"}.to_not raise_error(Lastfm::ApiError)
    end 
    it "should return an error" do
      expect {helper.get_album_info "snajdhskahdkjas", "wadjsjhdkasjkdsa"}.to raise_error(Lastfm::ApiError)
    end
  end

end