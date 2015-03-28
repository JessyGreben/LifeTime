class User < ActiveRecord::Base
	has_many :days, dependent: :destroy
	has_many :activities, through: :days
	has_many :authorizations, dependent: :destroy
end

