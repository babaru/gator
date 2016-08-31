module Gator
  class ProductTypes < ::Settingslogic
    source "#{Rails.root}/config/gator/product_types.yml"
    namespace Rails.env
  end
end
