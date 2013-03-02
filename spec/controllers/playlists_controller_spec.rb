# encoding: utf-8
require 'spec_helper'
describe PlaylistsController do
  before do
   @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create :user
    sign_in user
  end
  describe "Playlist Übersicht" do
    it "Alle Playlists werden angezeigt" do
      assigns(:playlists).should eq(Playlist.all)
    end
  end
end
