class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.string :name
      t.datetime :release

      t.timestamps
    end
  end
end
