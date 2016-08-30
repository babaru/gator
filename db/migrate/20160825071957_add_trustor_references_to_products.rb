class AddTrustorReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :trustor, index: true, foreign_key: true
  end
end
