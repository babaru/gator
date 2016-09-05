class RemoveAccountNumberFromSecuritiesBrokers < ActiveRecord::Migration
  def up
    remove_column :securities_brokers, :account_number
  end

  def down
    add_column :securities_brokers, :account_number, :string
  end
end
