class AddTypeColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type, :string

    Product.transaction do
      Product.all.each do |product|
        product.type = 'Product'
        product.save
      end
    end
  end
end
