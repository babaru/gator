class CreateProductManagers < ActiveRecord::Migration
  def change
    create_table :product_managers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
