class ChangeDecimalColumnsToStringProducts < ActiveRecord::Migration
  def up
    change_column :products, :initial_fund, :string
    change_column :products, :delegation_duration, :string
    change_column :products, :management_fee_ratio, :string
    change_column :products, :management_fee_flour, :string
    change_column :products, :trustor_fee_ratio, :string
    change_column :products, :operation_fee_ratio, :string
    change_column :products, :consultant_fee_ratio, :string
    change_column :products, :consultant_fee_flour, :string
    change_column :products, :sales_fee_ratio, :string
  end

  def down
    change_column :products, :initial_fund, :decimal
    change_column :products, :delegation_duration, :decimal
    change_column :products, :management_fee_ratio, :decimal
    change_column :products, :management_fee_flour, :decimal
    change_column :products, :trustor_fee_ratio, :decimal
    change_column :products, :operation_fee_ratio, :decimal
    change_column :products, :consultant_fee_ratio, :decimal
    change_column :products, :consultant_fee_flour, :decimal
    change_column :products, :sales_fee_ratio, :decimal
  end
end
