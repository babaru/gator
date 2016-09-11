class Staff < ActiveRecord::Base
  belongs_to :department
  belongs_to :user
  accepts_nested_attributes_for :department, reject_if: proc { |attrs| attrs[:name].blank? }
end
