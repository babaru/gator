class AddIsStructuredColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :is_structured, :boolean, default: false
  end
end
