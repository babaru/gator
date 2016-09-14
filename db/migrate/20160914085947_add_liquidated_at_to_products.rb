class AddLiquidatedAtToProducts < ActiveRecord::Migration
  def change
    add_column :products, :liquidated_at, :datetime
  end
end
