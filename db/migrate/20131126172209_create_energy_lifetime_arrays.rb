class CreateEnergyLifetimeArrays < ActiveRecord::Migration
  def change
    create_table :energy_lifetime_arrays do |t|
      t.text :raw_array
      t.text :parsed_array
      t.timestamps
    end
  end
end
