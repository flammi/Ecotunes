require 'spec_helper'

describe MusicexplorerController do

  describe "Rechtesystem" do
    it "HTTP Success Return Code wenn eingeloggt" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create :user
      sign_in user
      get 'explorer'
      response.should be_success
    end
    it "Failure, wenn nicht eingeloogt" do
      get 'explorer'
      response.should_not be_success
    end 
  end

  describe "#search" do
    before do 
      user = FactoryGirl.create :user
      sign_in user
      
      album = Album.new(:name => "Nord-Nord-Ost")
      album.save
      albumTest = Album.new(:name => "Test")
      albumTest.save


      artist = Artist.new(:name => "Subway to Sally")
      artist.save
      artistTest = Artist.new(:name => "Test")
      artistTest.save

      Song.create(:title => "Saraband de noir", :length => 55, :artist => artist, :album => album)
      Song.create(:title => "Testsong", :length => 55, :artist => artist, :album => album)
      Song.create(:title => "Blub", :length => 55, :artist => artistTest, :album => album)
      Song.create(:title => "Bla", :length => 55, :artist => artist, :album => albumTest)
      
      get 'search', {filter: "huhu"}
      resp = JSON.parse response.body
      resp['songs'].length.should eq(0)
    end
    it "Alle Lieder bei leerer Suche" do
      get 'search', {filter: ""}
      resp = JSON.parse response.body
      resp['songs'].length.should eq(4)
      response.body.should have_content "Saraband de noir"
    end

    it "Kein Lied bei Suche nach Schwachsinn" do
      get 'search', {filter: "huhu"}
      resp = JSON.parse response.body
      resp['songs'].length.should eq(0)
    end

    it "Mit title: suchen" do
      get 'search', {filter: "title:Test"}
      resp = JSON.parse response.body
      resp['songs'].length.should eq(1)
      resp['songs'][0]['artist']['name'].should eq("Subway to Sally")
    end
    it "Mit artist: suchen" do
      get 'search', {filter: "artist:Test"}
      resp = JSON.parse response.body
      resp['songs'].length.should eq(1)
      resp['songs'][0]['title'].should eq("Blub")
    end
    it "Mit album: suchen" do
      get 'search', {filter: "album:Test"}
      resp = JSON.parse response.body
      resp['songs'].length.should eq(1)
      resp['songs'][0]['title'].should eq("Bla")
    end
  end
end
