class AddRemarksToProducts < ActiveRecord::Migration
  def change
    add_column :products, :remarks, :text
  end
end
