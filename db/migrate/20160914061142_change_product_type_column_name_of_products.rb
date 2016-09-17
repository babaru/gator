class ChangeProductTypeColumnNameOfProducts < ActiveRecord::Migration
  def up
    rename_column :products, :product_type, :category
    rename_column :products, :product_dev_type, :rd_category
  end

  def down
    rename_column :products, :category, :product_type
    rename_column :products, :rd_category, :product_dev_type
  end
end
