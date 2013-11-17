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

end


# module SolarData

#   def initialize 
#   end

#   def self.get_energy_lifetime
#     uri = URI("https://api.enphaseenergy.com/api/systems/242524/energy_lifetime")
#     params = { :key => ENV["SOLAR_U_API_KEY"] }
#     uri.query = URI.encode_www_form(params)
#     res = Net::HTTP.get_response(uri)
#     parsedResponse = JSON.parse(res.body)
#     responseData = parsedResponse.values[2]
#     responseData.each_with_index.map do |value, index|
#       { x: index, y: value }
#     end
#   end  

# end