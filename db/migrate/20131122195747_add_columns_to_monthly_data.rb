class AddColumnsToMonthlyData < ActiveRecord::Migration
  def change
    add_column :monthly_data, :forMonth, :datetime
    add_column :monthly_data, :powerProduced, :integer
  end
end
