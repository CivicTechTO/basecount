class RenameHeadcounts < ActiveRecord::Migration[5.2]
  def change
    rename_column :historical_capacities, :total, :occupancy
    rename_table :historical_capacities, :headcounts
  end
end
