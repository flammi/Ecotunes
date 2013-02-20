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

artists = Artist.create([ { name: 'Eminem' }, { name: 'Die Toten Hosen' }, { name: 'Atreyu' } ])
albums = Album.create([ 
  { name: 'Infinite', artist: artists[0]}, 
  { name: 'The Slim Shady EP', artist: artists[0]}, 
  { name: 'The Slim Shady LP', artist: artists[0]}, 
  { name: 'The Marshall Mathers LP', artist: artists[0]}, 
  { name: 'The Eminem Show', artist: artists[0]}, 
  { name: 'Opel-Gang', artist: artists[1]}, 
  { name: 'Unter falscher Flagge', artist: artists[1]}, 
  { name: 'Damenwahl', artist: artists[1]}, 
  { name: 'Kauf MICH!', artist: artists[1]},
  { name: 'The Curse', artist: artists[2] },
  { name: 'A Death-Grip on Yesterday', artist: artists[2] },
  { name: 'Lead Sails Paper Anchor', artist: artists[2] },
  { name: 'Congregation of the Damned', artist: artists[2] } ])
songs = Song.create([ 
 { title: 'Shameful', album: albums[10], artist: artists[2] },
 { title: 'The Theft', album: albums[10], artist: artists[2] }, 
 { title: 'Ex’s and Oh’s', album: albums[10], artist: artists[2] },
 { title: 'Ich habe kein Album', artist: artists[0] } 
 ])
