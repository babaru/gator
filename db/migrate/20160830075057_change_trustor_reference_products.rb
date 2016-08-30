class ChangeTrustorReferenceProducts < ActiveRecord::Migration
  def up
    remove_reference :products, :trustor, index: true, foreign_key: true
    add_reference :products, :trustor_bank_account, index: true, foreign_key: true
  end

  def down
    remove_reference :products, :trustor_bank_account, index: true, foreign_key: true
    add_reference :products, :trustor, index: true, foreign_key: true
  end
end
