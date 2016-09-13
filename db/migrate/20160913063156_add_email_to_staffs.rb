class AddEmailToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :email, :string
    add_index :staffs, :email, unique: true
  end
end
