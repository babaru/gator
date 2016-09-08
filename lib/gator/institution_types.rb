module Gator
  class InstitutionTypes < ::Settingslogic
    source "#{Rails.root}/config/gator/institution_types.yml"
    namespace Rails.env
  end
end
