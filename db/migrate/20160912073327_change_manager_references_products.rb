class ChangeManagerReferencesProducts < ActiveRecord::Migration
  def up
    remove_reference :products, :product_manager, index: true, foreign_key: true
    add_reference :products, :staff, index: true, foreign_key: true
  end

  def down
    add_reference :products, :product_manager, index: true, foreign_key: true
    remove_reference :products, :staff, index: true, foreign_key: true
  end
end
