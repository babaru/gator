class Client < ActiveRecord::Base
  has_many :product_shares

  validates :category, :application_number, :id_number_type, :id_number,
    :name, :traded_at, :sales_man_code, :business_code, :branch_store_number, presence: true

  validates :person_in_charge_id_number_type, presence: true, if: :institution?
  validates :person_in_charge_id_number, presence: true, if: :institution?
  validates :person_in_charge_name, presence: true, if: :institution?
  validates :fund_trading_account_number, presence: true
  validates :fund_account_number, presence: true, unless: :new_record?

  attr_accessor :categories

  def active?
    status == 'active'
  end

  def individual?
    self.category == Gator::ClientCategory.client_categories.individual
  end

  def institution?
    self.category == Gator::ClientCategory.client_categories.institution
  end

  class << self

    def id_number_types
      Gator::IdNumberTypes.id_number_types.map{ |k,v| [I18n.t("id_number_types.#{k}"),v] }
    end

    def id_number_type_names
      Gator::IdNumberTypes.id_number_types.map{ |k,v| [v, I18n.t("id_number_types.#{k}")] }.to_h
    end

    def individual_institution
      Gator::IndividualInstitution.individual_institution.map{ |k,v| [I18n.t("individual_institution.#{k}"),v] }
    end

    def business_codes
      Gator::BusinessCodes.business_codes.map{ |k,v| [I18n.t("business_codes.#{k}"),v] }
    end

    def categories
      Gator::ClientCategory.client_categories.map { |k,v| [I18n.t("client_categories.#{k}"), v.to_s]}
    end

    def category_names
      Gator::ClientCategory.client_categories.map{ |k,v| [v, I18n.t("client_categories.#{k}")] }.to_h
    end

  end

end
