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
  { name: 'Infinite' }, 
  { name: 'The Slim Shady EP' }, 
  { name: 'The Slim Shady LP' }, 
  { name: 'The Marshall Mathers LP' }, 
  { name: 'The Eminem Show' }, 
  { name: 'Opel-Gang' },
  { name: 'Unter falscher Flagge' },
  { name: 'Damenwahl' }, 
  { name: 'Kauf MICH!' },
  { name: 'The Curse' },
  { name: 'A Death-Grip on Yesterday' },
  { name: 'Lead Sails Paper Anchor' },
  { name: 'Congregation of the Damned' } ])
songs = Song.create([ 
 { title: 'Lose Yourself' },
 { title: 'Shameful' },
 { title: 'The Theft' }, 
 { title: 'Ex’s and Oh’s' },
 { title: 'Ich habe kein Album'} 
 ])

artists[0].albums << albums[0]
albums[0].songs << songs[0]
artists[0].songs << songs[0]

