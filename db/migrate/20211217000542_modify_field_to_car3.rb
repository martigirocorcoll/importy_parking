class ModifyFieldToCar3 < ActiveRecord::Migration[6.0]
  def change
    remove_column :cars, :entry_time
    add_column :cars, :entry_time, :date
    remove_column :cars, :out_time
    add_column :cars, :out_time, :date
  end
end
