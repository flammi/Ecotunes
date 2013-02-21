class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :length
      t.string :path
      t.datetime :released
      t.integer :genre_id
      t.float :finger_print
      t.timestamps
    end
  end
end
