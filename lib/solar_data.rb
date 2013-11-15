module SolarData
   # baseURIo = 'https://api.enphaseenergy.com/api/systems/242524/'

  def initialize
    
  end

  def self.get_data(type)
    uri = URI("https://api.enphaseenergy.com/api/systems/242524/#{type}")
    params = { :key => '40de436ba96bef946401fcf18a66f021' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)


    parsedResponse = JSON.parse(res.body)
    responseData = parsedResponse.values[2]
    
    responseData.each_with_index.map do |value, index|
      { x: index, y: value }
    end
  end
end