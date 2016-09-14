class AddIsOneToManyColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_one_to_many, :boolean, default: false
  end
end
