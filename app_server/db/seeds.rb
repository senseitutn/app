# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Video
# name, path, description, duration, uploaded_at

video_list = [
	[ "duro de matar", nil, "se trata de un tipo que caga a corchazos a todos y nadie lo puede boletear", 2.15, nil],
	[ "frozen", nil, "otra pelicula ladri de disney sobre princesas", 1.15, nil],
	[ "piratas del caribe", nil, "johnny depp chorea otra vez con un personaje estrafalario",2.30,nil]
]

video_list.each do |video|
	Video.create( :name => video[0], :description => video[2], :duration => video[3])
end