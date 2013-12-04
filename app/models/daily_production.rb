class DailyProduction < ActiveRecord::Base
  # attr_accessible :title, :body
  serialize :production_totals

  scope :today_production, -> { where ('for_day.day: Time.now.day').last }
end
