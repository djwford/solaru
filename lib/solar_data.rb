module SolarData

  def initialize 
  end

  def self.get_energy_lifetime
    # make the api request
    uri = URI("https://api.enphaseenergy.com/api/systems/242524/energy_lifetime")
    params = { :key => ENV["SOLAR_U_API_KEY"] }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    # parse the response 
    parsedResponse = JSON.parse(res.body)
    # grab the production info
    responseData = parsedResponse.values[2]
    # grab the timestamp, convert into epoch time
    time = parsedResponse.values[1]
    parsedTime = time.scan(/\d{4}-\d{2}-\d{2}/).first
    epochTime = parsedTime.to_datetime.to_i
    # zip the timestamp and production data into a usable data object
    responseData.each_with_index.map do |value, index|
      { x: index + epochTime + (index * 86400), y: value }
    end
  end  
# ------------------------Monthly Production --------------------------

  def self.get_monthly_production
    uri=URI("https://api.enphaseenergy.com/api/systems/242524/monthly_production")
    # lastMonth = Time.now.beginning_of_month - 1.month
    # timeStart = lastMonth.strftime("%Y-%m-%d")   -- the date needs to be one month earlier. make the request on the second day
    #  of the month, requesting for the previous day, one month earlier
    timeStart = Date.today << 2  #this will need to be updated, once it works -- this is just for testing purposes
    params = { :key => ENV["SOLAR_U_API_KEY"], :start => "#{timeStart}" }  
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    parsedResponse = JSON.parse(res.body)
    @resultFromCall = parsedResponse.values[1]
    @monthlyData = MonthlyData.new
    @monthlyData.powerProduced = @resultFromCall
    @monthlyData.forMonth = Time.now
    @monthlyData.save
  end



  # may need a function to sort the months in the database to oldest first
  # also need a function to clean the database of any extraneous months

  def self.retrieve_monthly_data
    months_count = MonthlyData.count
    # select the last 12 months from the database
    months_count >= 12 ? months = MonthlyData.all[MonthlyData.count - 12..MonthlyData.count] : months = MonthlyData.all
    powerProducedArray = []
    MonthlyData.all.each do |x|
      powerProducedArray << x.powerProduced
    end
    starting_month = months[0].forMonth.month
    powerProducedArray.each_with_index.map do |value, index|
      { x: (index + starting_month), y: value }
    end
  end

# ------------------------Weekly Production --------------------------
 def self.get_weekly_production
    uri=URI("https://api.enphaseenergy.com/api/systems/242524/power_week")
    params = { :key => ENV["SOLAR_U_API_KEY"]}  
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    parsedResponse = JSON.parse(res.body)
    results = parsedResponse.values[2]
    weeklyData = WeeklyData.new
    weeklyData.weeklyProduction = results
    weeklyData.forWeek = Time.now
    weeklyData.save
  end



  # may need a function to sort the months in the database to oldest first
  # also need a function to clean the database of any extraneous months

  def self.retrieve_weekly_data
    weeks_count = WeeklyData.count
    weeks_count >= 6 ? weeks = WeeklyData.all[WeeklyData.count - 6..WeeklyData.count] : weeks = WeeklyData.all
  end

  def populate_database_with_weekly_data
    x = WeeklyData.first.weeklyProduction
    y = x.collect do |i|
      (i + 1) * (rand(5))
    end
    newWeek = WeeklyData.new
    newWeek.weeklyProduction = y
    newWeek.forWeek = Time.now
    newWeek.save
   end

# ------------------------Current Production --------------------------

  def self.get_current_production
    uri=URI("https://api.enphaseenergy.com/api/systems/242524/power_today")
    params = { :key => ENV["SOLAR_U_API_KEY"]}  
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    parsedResponse = JSON.parse(res.body)
    results = parsedResponse.values[2]
    dailyData = DailyProduction.new
    dailyData.production_totals = results
    dailyData.for_day = Time.now
    dailyData.save
  end

  
end 


