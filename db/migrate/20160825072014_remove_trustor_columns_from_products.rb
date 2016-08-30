class RemoveTrustorColumnsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :trustor_name
    remove_column :products, :trustor_account_name
    remove_column :products, :trustor_bank_name
    remove_column :products, :trustor_bank_account
  end

  def down
    add_column :products, :trustor_name, :string
    add_column :products, :trustor_account_name, :string
    add_column :products, :trustor_bank_name, :string
    add_column :products, :trustor_bank_account, :string
  end
end
