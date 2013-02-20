require 'spec_helper'

describe MusicUploadController do

  describe "GET 'MusicUpload'" do
    it "returns http success" do
      get 'MusicUpload'
      response.should be_success
    end
  end

end
