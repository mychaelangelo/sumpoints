class RemoveFormatFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :format_id, :integer
  end
end
