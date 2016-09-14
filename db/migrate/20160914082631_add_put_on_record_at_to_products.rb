class AddPutOnRecordAtToProducts < ActiveRecord::Migration
  def change
    add_column :products, :put_on_record_at, :datetime
  end
end
