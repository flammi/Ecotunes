require 'spec_helper'

describe ManagementController do
  describe "Managment Seite" do
    it "HTTP Success" do
      get 'management'
      response.should be_success
    end
  end
end
