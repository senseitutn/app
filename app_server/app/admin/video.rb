ActiveAdmin.register Video do
	scope "Pendientes de validación",:unchecked
	index do
		selectable_column
    	id_column
	    column "Título", :title
	    column "Url" do |video|
	    	link_to video.url, url_with_protocol(video.url)
	    end
	    # column "Aceptar video" do |video|
	    # 	link_to "Aceptar", admin_video_set_valid
	    # end
	    column "Fecha de subida", :uploaded_at
	    actions defaults: true do |video|
      		link_to 'Accept video', set_valid_admin_video_path(video.id), method: :put
    	end
	end
	
	member_action :set_valid, method: :put do
    	redirect_to admin_video_set_valid, notice: "Video aceptado"
    end

    controller do
    	def set_valid
    		@video = Video.find(params[:id])
    		@video.checked = true
    		@video.rejected = false
    		@video.save

    		redirect_to admin_videos_path
    	end
    end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
end
