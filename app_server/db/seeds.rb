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
	[ "duro de matar", nil, "se trata de un tipo que caga a corchazos a todos y nadie lo puede boletear", nil, nil],
	[ "frozen", nil, "otra pelicula ladri de disney sobre princesas", nil, nil],
	[ "piratas del caribe", nil, "johnny depp chorea otra vez con un personaje estrafalario", nil, nil]
]

video_list.each do |video|
	Video.create( :title => video[0], :description => video[2])
end

# User
# userame, password, name, surname, falied_login_count

user_list = [
	["pepe-perez","mipassword1","pepe","perez",nil],
	["mgarcia","mipassword2","mariano","garcia",nil],
	["fgomez","mipassword3","florencia","gomez",nil]
]

user_list.each do |user|
	User.create( :username => user[0], :password => user[1], :name => user[2], :surname => user[3])
end