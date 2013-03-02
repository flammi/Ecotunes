# encoding: utf-8
require 'spec_helper'
describe PlaylistsController do
  before do
   @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create :user
    sign_in user
  end

end
