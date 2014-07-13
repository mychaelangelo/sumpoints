class CreateFollowedposts < ActiveRecord::Migration
  def change
    create_table :followedposts do |t|
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
