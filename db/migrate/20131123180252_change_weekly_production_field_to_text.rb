class ChangeWeeklyProductionFieldToText < ActiveRecord::Migration
  def up
    remove_column(:weekly_data, :weeklyProduction)
    add_column :weekly_data, :weeklyProduction, :text
  end

  def down
  end
end
