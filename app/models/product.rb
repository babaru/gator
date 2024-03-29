class Product < ActiveRecord::Base
  belongs_to :staff
  belongs_to :sales_department, class_name: 'Department'
  belongs_to :operation_department, class_name: 'Department'
  belongs_to :consultant
  accepts_nested_attributes_for :staff, :sales_department,
    :operation_department, :consultant, reject_if: proc { |attrs| attrs[:name].blank? }

  has_many :product_shares
  has_many :product_tags
  has_many :tags, through: :product_tags

  validates :name, :short_name, :code, :client_code, uniqueness: true
  validates :superior_code, uniqueness: true, unless: "superior_code.blank?"
  validates :inferior_code, uniqueness: true, unless: "inferior_code.blank?"
  validates :superior_code, :inferior_code, :leverage, presence: true, if: "!!is_structured"
  validates :liquidated_at, presence: true, if: :is_liquidated?

  attr_accessor :categories

  # serialize :tag_names, Array

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

  def update_consultant_name
    unless self.consultant.nil?
      self.consultant_name = self.consultant.name
    else
      self.consultant_name = nil
    end
  end

  def is_liquidated?
    status == Gator::ProductStatus.product_statuses.liquidated
  end

  def diff(data)
    result = {}
    Product.column_names.each do |column_name|
      key = column_name.to_sym
      if data.key?(key) && key != :id && self.send(column_name) != data[key]
        result[key] = data[key]
      end
    end
    result
  end

  def commit_diff(diff, staff)
    update(diff.diff) && diff.update(is_committed: true, committed_by: staff, committed_at: Time.now)
  end

  def create_diff(data, staff)
    ProductDiff.create(diff_by: staff, diff_at: Time.now, diff: diff(data), product_id: self.id)
  end

  def uncommit_diffs
    ProductDiff.uncommitted.where(product_id: self.id)
  end

  class << self

    def categories
      Gator::ProductCategory.product_categories.map{ |k,v| [I18n.t("product_categories.#{k}"), v.to_s] }
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
