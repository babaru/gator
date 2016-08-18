class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :client_code
      t.string :short_name
      t.string :manager_name
      t.string :code
      t.integer :running_status
      t.string :type
      t.string :dev_type
      t.decimal :initial_fund
      t.string :trustor_name
      t.string :trustor_account_name
      t.string :trustor_bank_name
      t.string :trustor_bank_account
      t.string :securities_account_name
      t.string :securities_bank_name
      t.string :securities_capital_account
      t.string :valuation_out_sourcing
      t.datetime :deposited_at
      t.datetime :delegation_started_at
      t.datetime :delegation_ended_at
      t.decimal :delegation_duration
      t.string :fee_calculation_standard
      t.decimal :management_fee_ratio
      t.string :year_day_count
      t.decimal :management_fee_flour
      t.decimal :trustor_fee_ratio
      t.decimal :operation_fee_ratio
      t.decimal :investment_consultant_fee_ratio
      t.decimal :investment_consultant_fee_flour
      t.string :bonus
      t.decimal :sales_fee_ratio
      t.string :sse_account_code
      t.string :szse_account_code
      t.string :cffex_account_code
      t.string :zce_account_code
      t.string :dce_account_code
      t.string :shfe_account_code
      t.string :sales_department
      t.string :investment_consultant_reference_department
      t.string :operation_department
      t.string :investment_consultant_name
      t.string :sse_gateway
      t.string :szse_gateway

      t.timestamps null: false
    end
  end
end
