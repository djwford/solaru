class HomeController < ApplicationController

  before_filter :check_data, :only => [:index]
  # def index
  #   @users = User.all

  #   if user_signed_in? 
  #    redirect_to 'display'
  #    else
  #   render 'index'
  # end
  # end
  def index
    @energyLifetimeData = EnergyLifetimeArray.last.parsed_array
    @energyMonthlyData = SolarData.retrieve_monthly_data
    @energyWeeklyData = SolarData.retrieve_weekly_data
    
    @totalOutput = EnergyLifetimeArray.last.raw_array.reduce(:+)
    @averageOutput = (@totalOutput / (EnergyLifetimeArray.last.raw_array.count))
    @highestOutput = EnergyLifetimeArray.last.raw_array.max

   end
 
 
private
  def check_data
    SolarData.get_energy_lifetime if EnergyLifetimeArray.last.nil? 
    SolarData.get_monthly_production if MonthlyData.last.nil?
    SolarData.get_weekly_production if WeeklyData.last.nil?
    SolarData.get_current_production if DailyProduction.last.nil?
  end 
end

# if empty, get data