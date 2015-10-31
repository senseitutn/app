ActiveAdmin.register Video do
=begin
	index do
	    column :id
	    column "Título", :title
	    column "Url", :url
	    column "Fecha de subida", :uploaded_at
	    column "Pendiente de validación", :checked
	end
=end
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
