class AddShortNameToConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :short_name, :string
  end
end
