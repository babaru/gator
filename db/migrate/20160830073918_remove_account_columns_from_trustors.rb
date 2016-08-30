class RemoveAccountColumnsFromTrustors < ActiveRecord::Migration
  def up
    remove_column :trustors, :account_name
    remove_column :trustors, :account_number
    remove_reference :trustors, :bank, index: true, foreign_key: true
  end

  def down
    add_column :trustors, :account_name, :string
    add_column :trustors, :account_number, :string
    add_reference :trustors, :bank, index: true, foreign_key: true
  end
end
