class TrustorBankAccount < ActiveRecord::Base
  belongs_to :trustor
  belongs_to :bank
  accepts_nested_attributes_for :trustor, :bank, reject_if: proc { |attrs| attrs[:name].blank? }

  validates :name, :number, :bank_id, :trustor_id, presence: true
end
