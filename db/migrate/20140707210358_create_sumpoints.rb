class CreateSumpoints < ActiveRecord::Migration
  def change
    create_table :sumpoints do |t|
      t.text :body
      t.references :post, index: true

      t.timestamps
    end
  end
end
