# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'dbcfaker'

#create users
5.times do
	User.create!(
		firstname: DbcFaker::Name.first_name,
		lastname: DbcFaker::Name.last_name,
		age: 18 + rand(50),
		gender: [true, false].sample,
		weight_kgs: rand(45..115),
		height_meters: (1.25..2.5),
		image: Faker::Avatar.image
	)
end


num = (1..100).to_a

#create days
100.times do
	Day.create!(
		user_id: 1,
		activity_id: num.shift,
		life_expectancy: 2.46E9,
		life_gained_lost: rand(-86400..86400),
		total_lgl: rand(-86400..86400),
		date: Faker::Time.between(300.days.ago, Time.now)
	)

end

#create activities
100.times do
	Activity.create!(
		steps: rand(600..10000)
	)
end