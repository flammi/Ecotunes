class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.datetime :release
      t.integer :artist
      t.timestamps
    end
  end
end
