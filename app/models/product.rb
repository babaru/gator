class Product < ActiveRecord::Base
  belongs_to :product_manager
  belongs_to :trustor_bank_account
  belongs_to :securities_broker
  accepts_nested_attributes_for :product_manager, :trustor_bank_account
end
