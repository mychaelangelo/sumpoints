class CreatePostvotes < ActiveRecord::Migration
  def change
    create_table :postvotes do |t|
      t.integer :value
      t.references :user, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
