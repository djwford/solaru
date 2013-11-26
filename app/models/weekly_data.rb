class WeeklyData < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :all_days, :day1, :day2, :day3, :day4, :day5, :day6, :day7
  serialize :weeklyProduction

  def all_days
    weeklyProduction.in_groups_of(weeklyProduction.count / 7)
  end

  def weekly_production_total_by_days 
    all_days.map{|a| a.reduce(:+)}
  end

  def weekly_production_total_by_days_with_timestamps
    values = self.weekly_production_total_by_days.each_with_index.map{|total, index| [(self.forWeek+index.day).to_i, total] }
    
    values.map do |day|
       { x: day.split(',').first.first, y: day.split(',').first.last }
     end
  end

  def squash_weekly_data
    weeklyProduction.in_groups_of(7).map{|a| a.reduce(:+)}
  end


  
  def usage(day)
    day.reduce(:+)
  end

  (1..7).each do |i|
    WeeklyData.class_eval do
      define_method :"day#{i}" do
        weekly_production_total_by_days[i-1]
      end
    end
  end

end
