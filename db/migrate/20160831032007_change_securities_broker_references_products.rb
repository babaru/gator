class ChangeSecuritiesBrokerReferencesProducts < ActiveRecord::Migration
  def up
    add_reference :products, :securities_broker_account, index: true, foreign_key: true
    remove_reference :products, :securities_broker, index: true, foreign_key: true
  end

  def down
    add_reference :products, :securities_broker, index: true, foreign_key: true
    remove_reference :products, :securities_broker_account, index: true, foreign_key: true
  end
end
