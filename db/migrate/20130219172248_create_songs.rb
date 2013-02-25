class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :length
      t.string :path
      t.datetime :released
      t.integer :genre_id
      t.integer :album_id
      t.integer :artist_id
      t.string :finger_print
      t.integer :bitrate 
      t.string :channel_mode #e.g. Stereo
      t.timestamps
      t.integer :sample_rate
      t.integer :mpeg_version
      t.string :image_path
    end
  end

  def self.down
    drop_table :songs
  end
end
