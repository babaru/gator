class ChangeProductTypeColumnNameOfProducts < ActiveRecord::Migration
  def up
    rename_column :products, :category, :category
    rename_column :products, :rd_category, :rd_category
  end

  def down
    rename_column :products, :category, :category
    rename_column :products, :rd_category, :rd_category
  end
end
