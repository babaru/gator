class AddSalesDepartmentReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :sales_department, index: true
    add_foreign_key :products, :departments, column: :sales_department_id, primary_key: :id
  end
end
