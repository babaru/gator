class AddSzseGatewayToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :szse_gateway, :string
  end
end
