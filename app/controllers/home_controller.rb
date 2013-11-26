class HomeController < ApplicationController
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
    @averageOutput = (@totalOutput.to_f / (EnergyLifetimeArray.last.raw_array.count.to_f))
    @highestOutput = EnergyLifetimeArray.last.raw_array.max

   end
 
 


end
