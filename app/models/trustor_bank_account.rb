class TrustorBankAccount < ActiveRecord::Base
  belongs_to :trustor
  belongs_to :bank
  accepts_nested_attributes_for :trustor, :bank
end
