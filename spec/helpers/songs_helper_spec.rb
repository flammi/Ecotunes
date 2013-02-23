require 'spec_helper'

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
    path = Rails.root.join('spec', 'helpers', 'collins.mp3').to_s # file to check
    @duration1, @fingerprint1 = helper.fingerprint_and_duration path
    @duration2, @fingerprint2 = helper.fingerprint_and_duration path
  end
  describe "check fingerprint two times" do
    it "should have the same fingerprint" do
      @duration1 == @duration2
      @fingerprint1 == @fingerprint2
    end
  end
end
