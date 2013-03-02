require 'spec_helper'

describe UsersController do

  describe "GET 'user'" do
    it "returns http success" do
      get 'user'
      response.should be_success
    end
  end

end
