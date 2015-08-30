class ApiKey < ActiveRecord::Base
	before_create :generate_access_token
	
	belongs_to :user

	validates :user_id, uniqueness: :true

	private
		def generate_access_token
			begin
				self.access_token = SecureRandom.hex
				self.user_id = user_id
			end while self.class.exists?(access_token: access_token)		
		end
end
