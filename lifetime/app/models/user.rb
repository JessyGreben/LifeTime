class User < ActiveRecord::Base
	has_many :days
	has_many :activities, through: :days
end
