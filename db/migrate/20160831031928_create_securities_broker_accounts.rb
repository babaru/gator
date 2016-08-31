class CreateSecuritiesBrokerAccounts < ActiveRecord::Migration
  def change
    create_table :securities_broker_accounts do |t|
      t.references :securities_broker, index: true, foreign_key: true
      t.string :name
      t.string :number

      t.timestamps null: false
    end
  end
end
