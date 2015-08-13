# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Video
# tile, url, description, url_preview, uploaded_at

video_list = [
	[ "duro de matar", nil,"pelicula de acción protagonizada por Bruce Willis", nil, nil],
	[ "frozen", nil, "otra pelicula de disney sobre princesas", nil, nil],
	[ "piratas del caribe", nil, "una pelicula sobre piratas", nil, nil],
	[ "terminator", nil, "esto es una descripcion", nil, nil],
	[ "toy story", nil, "zzzzzzzzzzz", nil, nil],
	[ "rocky", nil, "una descripcion sobre la pelicula", nil, nil]
]

video_list.each do |video|
	Video.create( :title => video[0], :description => video[2])
end

# User
# userame, name, surname, mail_1, birthday, sex, id_facebook

user_list = [
	["pepe-perez","pepe","perez","pepeperez@gmail.com","male","23423642"],
	["mgarcia","mariano","garcia","mjg_ricotero@gmail.com","male","456456456"],
	["fgomez","florencia","gomez","la_rocha_de_lomas@gmail.com","female","123198231"]
]

user_list.each do |user|
	User.create( :username => user[0],:name => user[1], :surname => user[2], :mail_1 => user[3],
			:sex => user[4], :facebook_id => user[5])
end
