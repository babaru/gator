class AddProfitRatioToProducts < ActiveRecord::Migration
  def change
    add_column :products, :contract_profit_ratio, :string
    add_column :products, :spec_profit_ratio, :string
  end
end
