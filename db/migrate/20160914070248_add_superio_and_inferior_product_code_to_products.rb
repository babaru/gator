class AddSuperioAndInferiorProductCodeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :superior_code, :string
    add_index :products, :superior_code, unique: true
    add_column :products, :inferior_code, :string
    add_index :products, :inferior_code, unique: true
  end
end
