require 'spec_helper'

describe ApplicationController do

  before do
    controller = ApplicationController.new
    collins_path = Rails.root.join('spec', 'helpers', 'collins.mp3').to_s # file to check
    eminem_path = Rails.root.join('spec', 'helpers', 'eminem.mp3').to_s

    @duration1, @fingerprint1 = controller.fingerprint_and_duration collins_path
    @duration2, @fingerprint2 = controller.fingerprint_and_duration collins_path
    
    @duration3, @fingerprint3 = controller.fingerprint_and_duration eminem_path
  end

  describe "Test get_album_infos" do
    it "doesn't throw an error when there are only nil parameters" do
      (controller.get_album_infos nil, nil).should eq(nil)
    end

    it "should return a not-nil result for valide information" do
     picture = controller.get_album_infos "Eminem", "Recovery"
     picture.should_not eq (nil)
    end 

    it "should return nil,nil object because the given information arent valide" do
      picture = controller.get_album_infos "snajdhskahdkjas", "wadjsjhdkasjkdsa"
      picture.should eq (nil)
    end
  end

  describe "check fingerprint" do
    it "the same song should have the same fingerprint again" do
      @duration1.should eq(@duration2)
      @fingerprint1.should eq(@fingerprint2)
    end

    it "different songs should have different fingerprints" do
      @duration1.should_not eq(@duration3)
      @fingerprint1.should_not eq(@fingerprint3)
    end
  end

  describe "check album data" do
    it "should load image" do
      picture = controller.get_album_cover "Chris Brown", "Don't Wake Me Up"
      pic = URI.parse(picture)
    end
    it "image should be null" do
      (controller.get_album_cover "sjdkajsd", "sjdkajskda").should eq(nil)
    end
  end

  describe "tests albums and songs" do
    it "should have a songlist of 11 songs" do
      songs = controller.get_songs_from_album "Eminem", "Infinite"
      songs.should_not eq(nil)
      songs.length.should eq(11)
    end
  end

  describe "test description from album" do
    it "should have a description" do
      desc = controller.get_description_from_album "Eminem", "Infinite"
      desc.should_not eq(nil)
      desc.length.should_not eq(0)
    end
    it "shouldn't have a description" do
      desc = controller.get_description_from_album "sadsa", "dsadsadsad"
      desc.should eq(nil)
    end
  end

  describe "test artist-information" do
    it "should have information" do
      result = controller.get_artist_information "David Guetta"
      result.should_not eq(nil)

      image_result = controller.get_artist_image result
      image_result.should_not eq(nil)

      desc_result = controller.get_description_from_artist result
      desc_result.should_not eq(nil)
    end

    it "shouldn't have an information" do
      result = controller.get_artist_information "Malte Husmann"
      result.should eq(nil)
    end
  end

end