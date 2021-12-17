class ChangeColumnTypeAgain < ActiveRecord::Migration[6.0]
  def change
    remove_column :cars, :entry_time
    add_column :cars, :entry_time, :string
    remove_column :cars, :out_time
    add_column :cars, :out_time, :string
  end
end
