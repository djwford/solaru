class CreateMonthlyData < ActiveRecord::Migration
  def change
    create_table :monthly_data do |t|

      t.timestamps
    end
  end
end
