class AddUserReferenceToProductManagers < ActiveRecord::Migration
  def change
    add_reference :product_managers, :user, index: true, foreign_key: true
  end
end
