class RemoveIsIndividualFromClients < ActiveRecord::Migration
  def up
    remove_column :clients, :is_individual
  end

  def down
    add_column :clients, :is_individual, :boolean, :default => true
  end
end
