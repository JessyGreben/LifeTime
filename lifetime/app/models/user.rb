class User < ActiveRecord::Base
	has_many :days, dependent: :destroy
	has_many :activities, through: :days, dependent: :destroy
	has_one :authorization, dependent: :destroy
end

