class AddProductManagerReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :product_manager, index: true, foreign_key: true
  end
end
