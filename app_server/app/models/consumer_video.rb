class ConsumerVideo < ActiveRecord::Base
	belongs_to :consumer
	belongs_to :video
end
