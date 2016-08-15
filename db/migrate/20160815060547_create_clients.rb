class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :type
      t.string :application_number
      t.integer :id_number_type
      t.string :id_number
      t.string :name
      t.boolean :is_individual, default: true
      t.datetime :traded_at
      t.integer :person_in_charge_id_number_type
      t.string :person_in_charge_id_number
      t.string :person_in_charge_name
      t.string :fund_trading_account_number
      t.string :sales_man_code
      t.string :business_code
      t.string :branch_store_number
      t.string :fund_account_number

      t.timestamps null: false
    end
  end
end
