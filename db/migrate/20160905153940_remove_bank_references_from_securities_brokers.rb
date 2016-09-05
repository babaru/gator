class RemoveBankReferencesFromSecuritiesBrokers < ActiveRecord::Migration
  def up
    remove_reference :securities_brokers, :bank, index: true, foreign_key: true
  end

  def down
    add_reference :securities_brokers, :bank, index: true, foreign_key: true
  end
end
