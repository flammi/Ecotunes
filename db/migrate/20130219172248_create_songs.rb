class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :length
      t.string :path
      t.integer :album_id
      t.datetime :released
      t.integer :genre_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
