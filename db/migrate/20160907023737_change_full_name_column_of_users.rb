class ChangeFullNameColumnOfUsers < ActiveRecord::Migration
  def up
    rename_column :users, :full_name, :name
  end

  def down
    rename_column :users, :name, :full_name
  end
end
