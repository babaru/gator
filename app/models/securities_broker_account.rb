class SecuritiesBrokerAccount < ActiveRecord::Base
  belongs_to :securities_broker
  accepts_nested_attributes_for :securities_broker, reject_if: proc { |attrs| attrs[:name].blank? }

  validates :name, :number, :securities_broker_id, presence: true
end
