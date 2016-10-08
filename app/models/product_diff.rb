class ProductDiff < ActiveRecord::Base
  belongs_to :product
  belongs_to :diff_by, class_name: 'Staff'
  belongs_to :committed_by, class_name: 'Staff'

  serialize :diff, Hash
end
