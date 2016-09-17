class RemoveConsultantReferenceColumnProducts < ActiveRecord::Migration
  def up
    remove_reference :products, :consultant_reference_department, index: true, foreign_key: true
  end

  def down
    add_reference :products, :consultant_reference_department, index: true
    add_foreign_key :products, :departments, column: :consultant_reference_department_id, primary_key: :id
  end
end
