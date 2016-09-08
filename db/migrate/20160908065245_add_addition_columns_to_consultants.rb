class AddAdditionColumnsToConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :capital, :string
    add_column :consultants, :institution_type, :integer
    add_column :consultants, :person_in_charge_name, :string
    add_column :consultants, :is_qualified_3rd_party_institution, :boolean, default: true
    add_column :consultants, :company_address, :string
  end
end
