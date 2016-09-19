class AddInvestmentScopeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :investment_scope, :string
  end
end
