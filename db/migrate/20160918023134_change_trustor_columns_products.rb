class ChangeTrustorColumnsProducts < ActiveRecord::Migration
  def up
    remove_reference :products, :trustor_bank_account, index: true, foreign_key: true
    remove_reference :products, :securities_broker_account, index: true, foreign_key: true
    add_column :products, :trustor_name, :string
    add_column :products, :trustor_bank_name, :string
    add_column :products, :trustor_bank_account_name, :string
    add_column :products, :trustor_bank_account_number, :string
    add_column :products, :securities_broker_name, :string
    add_column :products, :securities_broker_account_number, :string
    add_column :products, :securities_broker_account_name, :string
  end

  def down
    add_reference :products, :trustor_bank_account, index: true, foreign_key: true
    add_reference :products, :securities_broker_account, index: true, foreign_key: true
    remove_column :products, :trustor_name
    remove_column :products, :trustor_bank_name
    remove_column :products, :trustor_bank_account_name
    remove_column :products, :trustor_bank_account_number
    remove_column :products, :securities_broker_name
    remove_column :products, :securities_broker_account_number
    remove_column :products, :securities_broker_account_name
  end
end
