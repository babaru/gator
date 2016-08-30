class Trustor < ActiveRecord::Base
  belongs_to :bank
  has_many :trustor_bank_accounts
  accepts_nested_attributes_for :bank
end
