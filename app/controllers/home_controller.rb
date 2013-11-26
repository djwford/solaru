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
    @energyLifetimeData = SolarData.get_energy_lifetime.to_json
    @energyMonthlyData = SolarData.retrieve_monthly_data.to_json
    @energyWeeklyData = SolarData.retrieve_weekly_data
   end


 


end
