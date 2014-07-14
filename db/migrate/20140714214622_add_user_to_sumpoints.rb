class AddUserToSumpoints < ActiveRecord::Migration
  def change
    add_column :sumpoints, :user_id, :integer
    add_index :sumpoints, :user_id
  end
end
