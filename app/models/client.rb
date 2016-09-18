class Client < ActiveRecord::Base
  validates :category, presence: true
  validates :application_number, presence: true
  validates :id_number_type, presence: true
  validates :id_number, presence: true
  validates :name, presence: true
  validates :traded_at, presence: true
  validates :person_in_charge_id_number_type, presence: true, if: :institution?
  validates :person_in_charge_id_number, presence: true, if: :institution?
  validates :person_in_charge_name, presence: true, if: :institution?
  validates :fund_trading_account_number, presence: true
  validates :sales_man_code, presence: true
  validates :business_code, presence: true
  validates :branch_store_number, presence: true
  validates :fund_account_number, presence: true, unless: :new_record?

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
      Gator::ClientCategory.client_categories.map { |k,v| [I18n.t("client_categories.#{k}"), v]}
    end

    def category_names
      Gator::ClientCategory.client_categories.map{ |k,v| [v, I18n.t("client_categories.#{k}")] }.to_h
    end

  end

end
