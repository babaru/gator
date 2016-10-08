class CreateProductDiffs < ActiveRecord::Migration
  def change
    create_table :product_diffs do |t|
      t.references :product, index: true, foreign_key: true
      t.integer :revision
      t.integer :diff_by_id
      t.text :diff
      t.boolean :is_committed
      t.integer :committed_by_id
      t.datetime :diff_at
      t.datetime :committed_at

      t.timestamps null: false
    end

    add_index :product_diffs, :diff_by_id
    add_index :product_diffs, :committed_by_id
    add_foreign_key :product_diffs, :staffs, column: :diff_by_id
    add_foreign_key :product_diffs, :staffs, column: :committed_by_id
  end
end
