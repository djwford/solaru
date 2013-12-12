class DailyProduction < ActiveRecord::Base
  # attr_accessible :title, :body
  serialize :production_totals

  # scope :today_production, -> { where( "for_day::timestamp::date = '#{ Time.now.to_date - 1.day }' " ) }
  scope :yesterday_production, -> { where( ['for_day::timestamp::date = ?', Time.now.to_date - 1.day] ).limit(1) }
  # scope :today_production, -> { where( ['for_day::timestamp::date = ?', Time.now.to_date.day] ).limit(1) }

end
