class CreateWeeklyData < ActiveRecord::Migration
  def change
    create_table :weekly_data do |t|

      t.timestamps
    end
  end
end
