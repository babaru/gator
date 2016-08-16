class Client < ActiveRecord::Base

  validates :type, presence: true
  validates :application_number, presence: true
  validates :id_number_type, presence: true
  validates :id_number, presence: true
  validates :name, presence: true
  validates :is_individual, presence: true
  validates :traded_at, presence: true
  validates :person_in_charge_id_number_type, presence: true
  validates :person_in_charge_id_number, presence: true
  validates :person_in_charge_name, presence: true
  validates :fund_trading_account_number, presence: true
  validates :sales_man_code, presence: true
  validates :business_code, presence: true
  validates :branch_store_number, presence: true
  validates :fund_account_number, presence: true

  def active?
    status == 'active'
  end

  class << self

    def id_number_types
      Gator::IdNumberTypes.id_number_types.map{ |k,v| [I18n.t("id_number_types.#{k}"),v] }
    end

    def individual_institution
      Gator::IndividualInstitution.individual_institution.map{ |k,v| [I18n.t("individual_institution.#{k}"),v] }
    end

    def business_codes
      Gator::BusinessCodes.business_codes.map{ |k,v| [I18n.t("business_codes.#{k}"),v] }
    end

  end

end
