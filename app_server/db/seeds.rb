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
	[ "Duro de Matar", "https://www.youtube.com/embed/3KojFVJHsuk","pelicula de acción protagonizada por Bruce Willis", nil, nil],
	[ "Stars Wars", "https://www.youtube.com/embed/6uG9vtckp1U", "pelicula de La Guerra de las Galaxias", nil, nil],
	[ "Jaguar Land Rover 360 experience", "https://www.youtube.com/embed/c98h41TkREA", "Jaguar Land Rover introduces the 360 Virtual Urban Windscreen. That's a great experience", nil, nil],
	[ "Mario is waiting for Love", "https://www.youtube.com/embed/3Rhd23g9bMM", "a 360 VR experience", nil, nil],
	[ "Flight over Exo-Water-Planet", "https://www.youtube.com/embed/fotD1D_h9x4", "Virtual reality version of a flight over a landscape. This short clip had been produced as an experiment to evaluate a new landscape generator Artmatic Voyager software package. The software can´t do fisheye, but 360° sperical panorama. Though it isn´t covering the whole 360°/180° FOV as needed as for creating a dome master, the result is more like a projected 360° video panorama. This is the masterfile which was used to create the fisheye DomeMaster, which you can see in another videoclip.", nil, nil],
	[ "Tokyo Japan", "https://www.youtube.com/embed/fotD1D_h9x4", "Feel as if you were in Tokyo Japan through  a 360 VR experience", nil, nil],
	[ "AirPano", "https://www.youtube.com/embed/h3LeVGOBjSg", "In 2014 AirPano Team again did a great job at the Epson International Pano Awards. Dmitry Moiseenko took the first place in VR / 360 Photo category.", nil, nil]
]

video_list.each do |video|
	Video.create( :title => video[0], :url => video[1], :description => video[2])
end

# User
# userame, name, surname, mail_1, birthday, sex, id_facebook

user_list = [
	["pepe-perez","pepe","perez","pepeperez@gmail.com","male","23423642"],
	["mgarcia","mariano","garcia","mjg_ricotero@gmail.com","male","456456456"],
	["fgomez","florencia","gomez","florenciagomez87@hotmail.com","female","123198231"],
	["ejimeno","evaristo","jimeno","evaristo_jimeno@gmail.com","male","228338221"],
	["serdeliverance","sergio","cano","serdeliverance@gmail.com","male","778320123"]
]

user_list.each do |user|
	User.create( :username => user[0],:name => user[1], :surname => user[2], :mail_1 => user[3],
			:gender => user[4], :facebook_id => user[5])
end

# Instancio usuarios y videos

@u1 = User.find(1)
@u2 = User.find(2)
@u3 = User.find(3)
@u4 = User.find(4)
@u5 = User.find(5)

@v1 = Video.find(1)
@v2 = Video.find(2)
@v3 = Video.find(3)
@v4 = Video.find(4)
@v5 = Video.find(5)
@v6 = Video.find(6)
@v7 = Video.find(7)

# Asocio videos a usuarios

@u1.videos << @v1
@u1.videos << @v4
@u1.videos << @v5

@u2.videos << @v1
@u2.videos << @v3

@u3.videos << @v7

@u4.videos << @v5
@u4.videos << @v6

@u5.videos << @v2
@u5.videos << @v4
@u5.videos << @v6

# Creo historiales de prueba

History.create(user_id: 1,video_id: 1,reproduced_at: DateTime.now)
History.create(user_id: 1,video_id: 1,reproduced_at: DateTime.now - 1)
History.create(user_id: 1,video_id: 4,reproduced_at: DateTime.now - 1)

History.create(user_id: 1,video_id: 2,reproduced_at: DateTime.now - 1)

History.create(user_id: 2,video_id: 1,reproduced_at: DateTime.now)
History.create(user_id: 2,video_id: 6,reproduced_at: DateTime.now - 7)

History.create(user_id: 3,video_id: 5,reproduced_at: DateTime.now)
History.create(user_id: 3,video_id: 2,reproduced_at: DateTime.now - 1)

History.create(user_id: 5,video_id: 5,reproduced_at: DateTime.now - 1)
History.create(user_id: 5,video_id: 7,reproduced_at: DateTime.now - 2)
History.create(user_id: 5,video_id: 7,reproduced_at: DateTime.now)

VideoService.increase_reproduction_count(1)
VideoService.increase_reproduction_count(1)
VideoService.increase_reproduction_count(1)
VideoService.increase_reproduction_count(2)
VideoService.increase_reproduction_count(2)
VideoService.increase_reproduction_count(4)
VideoService.increase_reproduction_count(5)
VideoService.increase_reproduction_count(5)
VideoService.increase_reproduction_count(6)
VideoService.increase_reproduction_count(7)
VideoService.increase_reproduction_count(7)

# Creo favourites de prueba

Favourite.create(:video_id => @v1.id, :user_id => @u1.id, :favourited_at => DateTime.now - 7)
Favourite.create(:video_id => @v2.id, :user_id => @u1.id, :favourited_at => DateTime.now - 7)
Favourite.create(:video_id => @v3.id, :user_id => @u1.id, :favourited_at => DateTime.now - 2)
Favourite.create(:video_id => @v7.id, :user_id => @u1.id, :favourited_at => DateTime.now - 3)

Favourite.create(:video_id => @v1.id, :user_id => @u2.id, :favourited_at => DateTime.now - 3)
Favourite.create(:video_id => @v2.id, :user_id => @u2.id, :favourited_at => DateTime.now)

Favourite.create(:video_id => @v5.id, :user_id => @u3.id, :favourited_at => DateTime.now)

Favourite.create(:video_id => @v5.id, :user_id => @u4.id, :favourited_at => DateTime.now)
Favourite.create(:video_id => @v6.id, :user_id => @u4.id, :favourited_at => DateTime.now)

Favourite.create(:video_id => @v4.id, :user_id => @u5.id, :favourited_at => DateTime.now - 5)

# --------No para este sprint

=begin
# Creacion de imagenes
@image1 = Image.new(:video_id => 1,:image => File.new("#{Rails.root}/imagenes_test/duro-de-matar.jpeg", "r"))
@image2 = Image.new(:video_id => 2,:image => File.new("#{Rails.root}/imagenes_test/coraje.jpeg", "r"))
@image3 = Image.new(:video_id => 3,:image => File.new("#{Rails.root}/imagenes_test/shrek.jpeg", "r"))
@image4 = Image.new(:video_id => 4,:image => File.new("#{Rails.root}/imagenes_test/busqueda-implacable.jpeg", "r"))
@image5 = Image.new(:video_id => 5,:image => File.new("#{Rails.root}/imagenes_test/conejo.jpg", "r"))
@image6 = Image.new(:video_id => 6,:image => File.new("#{Rails.root}/imagenes_test/paisaje.jpeg", "r"))
@image7 = Image.new(:video_id => 7,:image => File.new("#{Rails.root}/imagenes_test/dragon.jpg", "r"))

@video1 = Video.find(1)
@video1.url_preview = @image1.image.url
@video1.save

@video2 = Video.find(2)
@video2.url_preview = @image2.image.url
@video2.save

@video3 = Video.find(3)
@video3.url_preview = @image3.image.url
@video3.save

@video4 = Video.find(4)
@video4.url_preview = @image4.image.url
@video4.save

@video5 = Video.find(5)
@video5.url_preview = @image5.image.url
@video5.save

@video6 = Video.find(6)
@video6.url_preview = @image6.image.url
@video6.save

@video7 = Video.find(7)
@video7.url_preview = @image7.image.url
@video7.save

=end