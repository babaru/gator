class RemoveDepartmentColumnsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :sales_department
    remove_column :products, :operation_department
    remove_column :products, :investment_consultant_reference_department
    rename_column :products, :investment_consultant_name, :consultant_name
  end

  def down
    add_column :products, :sales_department, :string
    add_column :products, :operation_department, :string
    add_column :products, :investment_consultant_reference_department, :string
    rename_column :products, :consultant_name, :investment_consultant_name
  end
end
