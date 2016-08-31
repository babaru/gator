class SecuritiesBroker < ActiveRecord::Base
  belongs_to :bank

  validates :name, presence: true
end
