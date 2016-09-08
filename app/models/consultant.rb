class Consultant < ActiveRecord::Base
  belongs_to :department
  has_many :products
  validates :name, :institution_type, presence: true
  accepts_nested_attributes_for :department, reject_if: proc { |attrs| attrs[:name].blank? }

  class << self
    def institution_types
      Gator::InstitutionTypes.institution_types.map{ |k,v| [I18n.t("institution_types.#{k}"),v] }
    end

    def institution_type_names
      Gator::InstitutionTypes.institution_types.map{ |k,v| [v, I18n.t("institution_types.#{k}")] }.to_h
    end
  end
end
