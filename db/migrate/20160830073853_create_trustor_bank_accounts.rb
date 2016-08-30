class CreateTrustorBankAccounts < ActiveRecord::Migration
  def change
    create_table :trustor_bank_accounts do |t|
      t.references :trustor, index: true, foreign_key: true
      t.references :bank, index: true, foreign_key: true
      t.string :name
      t.string :number

      t.timestamps null: false
    end
  end
end
