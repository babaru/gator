class Staff < ActiveRecord::Base
  belongs_to :department
  belongs_to :user
  accepts_nested_attributes_for :department, reject_if: proc { |attrs| attrs[:name].blank? }

  validates :name, presence: true
  validates :email, uniqueness: true, unless: "email.nil?"

  def committed_product_diffs
    ProductDiff.where(committed_by_id: self)
  end

  def product_diffs
    ProductDiff.where(diff_by_id: self.id)
  end
end
