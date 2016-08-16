module Gator
  class BusinessCodes < ::Settingslogic
    source "#{Rails.root}/config/gator/business_codes.yml"
    namespace Rails.env
  end
end
