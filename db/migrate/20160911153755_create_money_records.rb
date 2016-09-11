class CreateMoneyRecords < ActiveRecord::Migration
  def change
    create_table :money_records do |t|
      t.datetime :done_at
      t.string :type
      t.decimal :amount
      t.references :staff, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
