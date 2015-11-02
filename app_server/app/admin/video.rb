ActiveAdmin.register Video do
	scope "Pendientes de validación",:unchecked
	index do
		selectable_column
    	id_column
	    column "Título", :title
	    column "Url" do |video|
	    	link_to video.url, url_with_protocol(video.url)
	    end 
	    column "Fecha de subida", :uploaded_at
	    column "Válido", :checked
	    actions
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
