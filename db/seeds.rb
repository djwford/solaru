# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
# puts 'DEFAULT USERS'
# user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
# puts 'user: ' << user.name

#  


# to populate:
#  all-time
#     one call
#  weekly
#     all weeks on record
#  monthly
#     all months on record
#  yesterday
#     one call


# energy lifetime
SolarData.get_energy_lifetime

3.times do |x|
  y=WeeklyData.new
  dummy_array = []
  7.times do
    dummy_array  << (Random.rand(100) * 222) / 10
  end
  y.weeklyProduction = dummy_array
  y.forWeek = Time.now - (x + 1).months
  y.save
end

# weekly

SolarData.get_weekly_production



# monthly
first_response = HTTParty.get('https://api.enphaseenergy.com/api/systems/242524/energy_lifetime?key=40de436ba96bef946401fcf18a66f021')["production"]

 
september = Array.new(first_response[0..18]) 
october = Array.new(first_response[19..49])
november = Array.new(first_response[50..79])

  sept = MonthlyData.new
  sept.forMonth = Date.new(2013,9,1)
  sept.powerProduced = september.reduce(:+)
  sept.save


  nov = MonthlyData.new
  nov.forMonth = Date.new(2013,11,1)
  nov.powerProduced = november.reduce(:+)
  nov.save


  oct = MonthlyData.new
  oct.forMonth = Date.new(2013,10,01)
  oct.powerProduced = october.reduce(:+)
  oct.save
 

