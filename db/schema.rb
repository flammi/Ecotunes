# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130222190613) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "release"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "albums_artists", :id => false, :force => true do |t|
    t.integer "album_id"
    t.integer "artist_id"
  end

  create_table "albums_songs", :id => false, :force => true do |t|
    t.integer "song_id"
    t.integer "album_id"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "artists_songs", :id => false, :force => true do |t|
    t.integer "song_id"
    t.integer "artist_id"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "playlists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "playlists_songs", :id => false, :force => true do |t|
    t.integer "playlist_id"
    t.integer "song_id"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.integer  "length"
    t.string   "path"
    t.datetime "released"
    t.integer  "genre_id"
    t.float    "finger_print"
    t.integer  "bitrate"
    t.string   "channel_mode"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "sample_rate"
    t.integer  "mpeg_version"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
  end

end
