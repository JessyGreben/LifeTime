class User < ActiveRecord::Base
	has_many :days
	has_many :activities, through: :days
	has_many :authorizations
end

