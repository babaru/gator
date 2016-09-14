class AddLeverageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :leverage, :string
  end
end
