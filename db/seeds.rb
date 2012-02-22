# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Sam Ho', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name

puts 'SETTING UP DEFAULT MEETUP USER'
MeetupMember.create!(:name => "Sam Ho", 
                  :user_id => 1,
                  :meetup_id => 6442685, 
                  :unparsed_json => [381, 4422, 9696, 10102, 9760, 55324, 18062, 37381, 29971, 115913, 30928, 456, 98380, 10538, 77098, 38968, 21681, 91146, 18060, 15167, 27591, 121802, 20837, 17158, 46616, 38660, 57242, 29000, 99211, 99649, 155621, 62649],
                  :image_url => "http://photos1.meetupstatic.com/photos/member/5/9/e/member_5707438.jpeg", 
                  :linkedin_url => "http://www.linkedin.com/in/samho",
                  :twitter => "@sammho"   )


