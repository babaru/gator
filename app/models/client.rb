class Client < ActiveRecord::Base

  validates :type, presence: true, :if => :active?
  validates :application_number, presence: true, :if => :active?
  validates :id_number_type, presence: true, :if => :active?
  validates :id_number, presence: true, :if => :active?
  validates :name, presence: true, :if => :active?
  validates :is_individual, presence: true, :if => :active?
  validates :traded_at, presence: true, :if => :active?
  validates :person_in_charge_id_number_type, presence: true, :if => :active?
  validates :person_in_charge_id_number, presence: true, :if => :active?
  validates :person_in_charge_name, presence: true, :if => :active?
  validates :fund_trading_account_number, presence: true, :if => :active?
  validates :sales_man_code, presence: true, :if => :active?
  validates :business_code, presence: true, :if => :active?
  validates :branch_store_number, presence: true, :if => :active?
  validates :fund_account_number, presence: true, :if => :active?

  def active?
    status == 'active'
  end

end
