class AddOperationDepartmentReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :operation_department, index: true
    add_foreign_key :products, :departments, column: :operation_department_id, primary_key: :id
  end
end
