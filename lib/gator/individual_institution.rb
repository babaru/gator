module Gator
  class IndividualInstitution < ::Settingslogic
    source "#{Rails.root}/config/gator/individual_institution.yml"
    namespace Rails.env
  end
end
