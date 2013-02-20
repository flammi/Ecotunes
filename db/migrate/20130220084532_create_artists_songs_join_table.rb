class CreateArtistsSongsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :artists_songs, :id => false do |t|
      t.integer :song_id
      t.integer :artist_id     
    end
  end

  def self.down
    drop_table :artists_songs
  end
end
