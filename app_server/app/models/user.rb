class User < ActiveRecord::Base
	has_one :api_key
end
