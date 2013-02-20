class CreateAlbumsSongsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :albums_songs, :id => false do |t|
      t.integer :song_id
      t.integer :album_id     
    end
  end

  def self.down
    drop_table :albums_songs
  end
end
