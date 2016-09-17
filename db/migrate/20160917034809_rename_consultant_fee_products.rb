class RenameConsultantFeeProducts < ActiveRecord::Migration
  def up
    rename_column :products, :investment_consultant_fee_ratio, :consultant_fee_ratio
    rename_column :products, :investment_consultant_fee_flour, :consultant_fee_flour
  end

  def down
    rename_column :products, :consultant_fee_ratio, :investment_consultant_fee_ratio
    rename_column :products, :consultant_fee_flour, :investment_consultant_fee_flour
  end
end
