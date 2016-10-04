class AddTagNamesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :tag_names, :string
  end
end
