class CreateProductShares < ActiveRecord::Migration
  def change
    create_table :product_shares do |t|
      t.references :product, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.decimal :share

      t.timestamps null: false
    end
  end
end
