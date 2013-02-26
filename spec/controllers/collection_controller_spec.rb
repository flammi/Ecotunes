require 'spec_helper'

describe CollectionController do

  describe "GET 'collection'" do
    it "returns http success" do
      get 'collection'
      response.should be_success
    end
  end

end
