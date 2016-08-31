class AddConsultantReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :consultant, index: true, foreign_key: true
  end
end
