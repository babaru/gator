class AddSecuritiesBrokerReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :securities_broker, index: true, foreign_key: true
  end
end
