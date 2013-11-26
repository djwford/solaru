class AddColumnsToWeeklyData < ActiveRecord::Migration
  def change
    add_column :weekly_data, :forWeek, :datetime
    add_column :weekly_data, :weeklyProduction, :integer

  end
end
