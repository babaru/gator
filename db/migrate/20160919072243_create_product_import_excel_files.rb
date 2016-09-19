class CreateProductImportExcelFiles < ActiveRecord::Migration
  def change
    create_table :product_import_excel_files do |t|
      t.attachment :file
      t.string :attachment_access_token

      t.timestamps null: false
    end
  end
end
