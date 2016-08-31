class Consultant < ActiveRecord::Base
  belongs_to :department
  validates :name, presence: true
end
