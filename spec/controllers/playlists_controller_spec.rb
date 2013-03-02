require 'spec_helper'
# encoding: utf-8
describe PlaylistsController do
  describe "Playlist Übersicht" do
    it "Alle Playlists werden angezeigt" do
      assigns(:playlists).should eq([playlist])
    end
  end
end
