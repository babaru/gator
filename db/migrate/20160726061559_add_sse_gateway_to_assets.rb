class AddSseGatewayToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :sse_gateway, :string
  end
end
