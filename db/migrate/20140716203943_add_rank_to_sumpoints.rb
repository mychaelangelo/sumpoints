class AddRankToSumpoints < ActiveRecord::Migration
  def change
    add_column :sumpoints, :rank, :float
  end
end
