class RemoveSecuritiesBrokerColumnsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :securities_account_name
    remove_column :products, :securities_bank_name
    remove_column :products, :securities_capital_account
  end

  def down
    add_column :products, :securities_account_name, :string
    add_column :products, :securities_bank_name, :string
    add_column :products, :securities_capital_account, :string
  end
end
