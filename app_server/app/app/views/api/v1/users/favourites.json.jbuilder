#json.array! @favourites do |favourite|
#	json.id favourite.video_id
#	json.favourited_at favourite.favourited_at
#end


#@favourite.each do |f|
#	json.id f.video_id
#	json.favourited_at f.favourited_at
#end

json.array! @favourites, :video_id, :user_id, :favourited_at