class AddNameIndexToProducts < ActiveRecord::Migration
  def change
    add_index :products, :name, unique: true
    add_index :products, :short_name, unique: true
    add_index :products, :code, unique: true
    add_index :products, :client_code, unique: true
  end
end
