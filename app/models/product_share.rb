class ProductShare < ActiveRecord::Base
  belongs_to :product
  belongs_to :client
  accepts_nested_attributes_for :product, :client, reject_if: proc { |attrs| attrs[:name].blank? || attrs[:id].blank? }

  validates :share, presence: true
end
