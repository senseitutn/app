class User < ActiveRecord::Base
	has_one :api_key

	has_many :favoutires
	has_many :videos, :through => :favoutires

	has_many :histories
	has_many :videos, :through => :histories

	has_and_belongs_to_many :videos
	# has_many :user_videos
	# has_many :videos, :through => :user_videos

# autenticacion cliente web:
# Descomentar el siguiente codigo en caso de queres un sistema de autenticacion de cliente web

	# # TODO check validations to mail_1, 2 y 3
	# # TODO add validations to cel_1 y 2
	# before_save { self.mail_1 = mail_1.downcase, 
	# 	self.mail_2 = mail_2.downcase,
	# 	self.mail_3 = mail_3.downcase
	# }
	
	# #mail validations

 #  	validates :name, presence: true, length: { maximum: 50 }
 #  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 #  	validates :mail_1, presence: true, length: { maximum: 255 },
 #        format: { with: VALID_EMAIL_REGEX },
 #        uniqueness: { case_sensitive: false }
 #    validates :mail_2, presence: true, length: { maximum: 255 },
 #    format: { with: VALID_EMAIL_REGEX },
 #    uniqueness: { case_sensitive: false }
	# validates :mail_3, presence: true, length: { maximum: 255 },
 #        format: { with: VALID_EMAIL_REGEX },
 #        uniqueness: { case_sensitive: false }
 #  	validates :password, presence: true, length: { minimum: 6 }
	
 #  	# this is a method provided for rails which allows us to make validations 
 #  	# against a hash table in our database
	
	# has_secure_password 
end
