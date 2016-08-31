class Trustor < ActiveRecord::Base
  has_many :trustor_bank_accounts

  validates :name, presence: true
end
