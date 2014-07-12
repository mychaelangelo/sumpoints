class AddFormatToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :format_id, :integer
    add_index :posts, :format_id
  end
end
