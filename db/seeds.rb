# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

artists = Artist.create([ { name: 'Eminem' }, { name: 'Die toten Hosen' }, { name: 'Madonna' } ])
albums = Album.create([ { name: 'Slim Shady' }, { name: 'Ballast der Republik' }, { name: 'Celebration' } ])
songs = Song.create([ { name: 'Tage wie diese' }, { name: 'Altes Fieber' }, { name: 'Ich würde nie zum FC Bayern gehen' } ])