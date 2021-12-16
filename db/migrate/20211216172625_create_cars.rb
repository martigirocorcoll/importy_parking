class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :entry_time
      t.string :out_time

      t.timestamps
    end
  end
end
