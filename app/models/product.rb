class Product < ActiveRecord::Base
  belongs_to :staff
  belongs_to :trustor_bank_account
  belongs_to :securities_broker_account
  belongs_to :sales_department, class_name: 'Department'
  belongs_to :operation_department, class_name: 'Department'
  belongs_to :consultant_reference_department, class_name: 'Department'
  belongs_to :consultant
  accepts_nested_attributes_for :staff, :sales_department,
    :operation_department, :consultant, reject_if: proc { |attrs| attrs[:name].blank? }

  validates :name, :short_name, :code, :client_code, uniqueness: true
  validates :superior_code, uniqueness: true, unless: "superior_code.blank?"
  validates :inferior_code, uniqueness: true, unless: "inferior_code.blank?"
  validates :superior_code, :inferior_code, :leverage, presence: true, if: "!!is_structured"

  validates :name,
    :client_code,
    :short_name,
    :code,
    :status,
    :category,
    :rd_category,
    :initial_fund,
    # :valuation_out_sourcing,
    :deposited_at,
    :delegation_started_at,
    :delegation_ended_at,
    # :delegation_duration,
    # :fee_calculation_standard,
    # :management_fee_ratio,
    # :year_day_count,
    # :management_fee_flour,
    # :trustor_fee_ratio,
    # :operation_fee_ratio,
    # :investment_consultant_fee_ratio,
    # :investment_consultant_fee_flour,
    # :bonus,
    # :sales_fee_ratio,
    # :sse_account_code,
    # :szse_account_code,
    # :cffex_account_code,
    # :zce_account_code,
    # :dce_account_code,
    # :shfe_account_code,
    # :consultant_name,
    presence: true

  # Data Compliance Callbacks
  before_save :update_consultant_name

  # def initialize
  #   super
  #   build_staff
  #   build_consultant
  #   build_sales_department
  #   build_operation_department
  #   is_structured = false
  # end

  # def initialize(attributes = {}, options = {})
  #   super(attributes, options)
  #   build_staff if staff_id.nil?
  #   build_consultant
  #   build_sales_department if sales_department_id.nil?
  #   build_operation_department if operation_department_id.nil?
  # end

  def update_consultant_name
    unless self.consultant.nil?
      self.consultant_name = self.consultant.name
    else
      self.consultant_name = nil
    end
  end

  class << self

    def categories
      Gator::ProductCategory.product_categories.map{ |k,v| [I18n.t("product_categories.#{k}"),v] }
    end

    def category_names
      Gator::ProductCategory.product_categories.map{ |k,v| [v, I18n.t("product_categories.#{k}")] }.to_h
    end

    def rd_categories
      Gator::ProductRDCategory.product_rd_categories.map{ |k,v| [I18n.t("product_rd_categories.#{k}"),v] }
    end

    def rd_category_names
      Gator::ProductRDCategory.product_rd_categories.map{ |k,v| [v, I18n.t("product_rd_categories.#{k}")] }.to_h
    end

    def statuses
      Gator::ProductStatus.product_statuses.map{ |k,v| [I18n.t("product_statuses.#{k}"),v] }
    end

    def status_names
      Gator::ProductStatus.product_statuses.map{ |k,v| [v, I18n.t("product_statuses.#{k}")] }.to_h
    end

  end
end
