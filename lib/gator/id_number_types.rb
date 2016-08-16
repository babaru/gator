module Gator
  class IdNumberTypes < ::Settingslogic
    source "#{Rails.root}/config/gator/id_number_types.yml"
    namespace Rails.env
  end
end
