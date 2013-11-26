class EnergyLifetimeArray < ActiveRecord::Base
  # attr_accessible :title, :body

serialize :raw_array
serialize :parsed_array
end
