class ChangeTypeColumnProducts < ActiveRecord::Migration
  def up
    change_column :products, :type, :integer
    change_column :products, :dev_type, :integer
    rename_column :products, :type, :product_type
    rename_column :products, :dev_type, :product_dev_type
  end

  def down
    rename_column :products, :product_type, :type
    rename_column :products, :product_dev_type, :dev_type
    change_column :products, :type, :string
    change_column :products, :dev_type, :string
  end
end
