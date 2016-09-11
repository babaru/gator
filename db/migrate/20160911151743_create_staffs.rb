class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.references :department, index: true, foreign_key: true
      t.string :position
      t.string :duration
      t.string :office_tel
      t.string :mobile
      t.text :resume
      t.boolean :is_investment_manager
      t.string :certification_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
