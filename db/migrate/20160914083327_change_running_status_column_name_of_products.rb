class ChangeRunningStatusColumnNameOfProducts < ActiveRecord::Migration
  def up
    rename_column :products, :running_status, :status
    change_column :products, :status, :integer, default: 0
  end

  def down
    rename_column :products, :status, :running_status
  end
end
