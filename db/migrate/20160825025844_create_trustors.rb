class CreateTrustors < ActiveRecord::Migration
  def change
    create_table :trustors do |t|
      t.string :name
      t.references :bank, index: true, foreign_key: true
      t.string :account_name
      t.string :account_number

      t.timestamps null: false
    end
  end
end
