class AddGatewaysToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cffex_gateway, :string
    add_column :products, :zce_gateway, :string
    add_column :products, :dce_gateway, :string
    add_column :products, :shfe_gateway, :string
  end
end
