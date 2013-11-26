class CreateDailyProductions < ActiveRecord::Migration
  def change
    create_table :daily_productions do |t|
      t.datetime :for_day
      t.text :production_totals
      t.timestamps
    end
  end
end
