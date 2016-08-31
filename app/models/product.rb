class Product < ActiveRecord::Base
  belongs_to :product_manager
  belongs_to :trustor_bank_account
  belongs_to :securities_broker_account
  belongs_to :sales_department, class_name: 'Department'
  belongs_to :operation_department, class_name: 'Department'
  belongs_to :consultant_reference_department, class_name: 'Department'
  belongs_to :consultant
  accepts_nested_attributes_for :product_manager, :sales_department,
    :operation_department, :consultant_reference_department,
    :consultant, reject_if: proc { |attrs| attrs[:name].blank? }


  # validates :name, uniqueness: true

  # validates :product_manager, presence: true

  validates :name,
    :client_code,
    :short_name,
    :code,
    :running_status,
    :type,
    :dev_type,
    :initial_fund,
    :valuation_out_sourcing,
    :deposited_at,
    :delegation_started_at,
    :delegation_ended_at,
    :delegation_duration,
    :fee_calculation_standard,
    :management_fee_ratio,
    :year_day_count,
    :management_fee_flour,
    :trustor_fee_ratio,
    :operation_fee_ratio,
    :investment_consultant_fee_ratio,
    :investment_consultant_fee_flour,
    :bonus,
    :sales_fee_ratio,
    :sse_account_code,
    :szse_account_code,
    :cffex_account_code,
    :zce_account_code,
    :dce_account_code,
    :shfe_account_code,
    :consultant_name, presence: true
end
