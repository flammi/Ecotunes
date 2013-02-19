# -*- coding:UTF-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Artist.delete_all
Album.delete_all
Song.delete_all

artists = Artist.create([ { name: 'Eminem' }, { name: 'Die toten Hosen' }, { name: 'Madonna' } ])
albums = Album.create([ 
  { name: 'Slim Shady', artist: artists[0]}, 
  { name: 'Ballast der Republik', artist: artists[1]}, 
  { name: 'Celebration', artist: artists[2] } ])
songs = Song.create([ 
 { title: 'Tage wie diese', album: albums[0], artist: artists[0] },
 { title: 'Altes Fieber', album: albums[1], artist: artists[1] }, 
 { title: 'Ich würde nie zum FC Bayern gehen', album: albums[2], artist: artists[2] },
 { title: 'Ich habe kein Album', artist: artists[0] } 
 ])
