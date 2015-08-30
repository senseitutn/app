class ConsumersController < ApplicationController
	def index
		@consumers = Consumer.all
	end

	def show
		@consumer = Consumer.find(params[:id])
	end

	def new
		@consumer = Consumer.new
	end

	def edit
		@consumer = Consumer.find(params[:id])
	end

	def create
		@consumer = Consumer.new(consumer_params)

		if @consumer.save
			flash[:notice] = 'Se ha creado el consumidor(usuario)'
			redirect_to @consumer
		else
			flash[:notice] = "No se ha podido crear el consumidor(usuario)"
			render "new"
		end
	end

	def update
		@consumer = Consumer.find(params[:id])

		if @consumer.update(consumer_params)
			flash[:notice] = "Los datos de han actualizado correctamente"
			redirect_to @consumer
		else
			flash[:notice] = "No se han podido actualizar los datos"
			render "edit"
		end
	end

	def destroy
		@consumer = Consumer.find[:id]
		@consumer.destroy

		redirect_to consumer_path
	end

	private
	def consumer_params
		# --------- comento lo que sigue porque todavia no esta implementada la validación via token de acceso
		#	params.require(:consumer).permit(:token_fb, :image_url, :mail_1, :mail_2, :mail_3, :cel_1, :cel_2, :birthday, :country)

		#entonces por ahora usamos esto:
		params.require(:consumer).permit(:image_url, :mail_1, :mail_2, :mail_3, :cel_1, :cel_2, :birthday, :country, :sex)
	end
end
