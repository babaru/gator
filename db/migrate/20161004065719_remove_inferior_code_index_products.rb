class RemoveInferiorCodeIndexProducts < ActiveRecord::Migration
  def up
    remove_index :products, :inferior_code
    remove_index :products, :superior_code
  end

  def down
    # add_index "products", ["inferior_code"], name: "index_products_on_inferior_code", unique: true, using: :btree
    # add_index "products", ["superior_code"], name: "index_products_on_superior_code", unique: true, using: :btree
  end
end
