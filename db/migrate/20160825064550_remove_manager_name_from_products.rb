class RemoveManagerNameFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :manager_name
  end

  def down
    add_column :products, :manager_name, :string
  end
end
