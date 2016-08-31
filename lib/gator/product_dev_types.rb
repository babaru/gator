module Gator
  class ProductDevTypes < ::Settingslogic
    source "#{Rails.root}/config/gator/product_dev_types.yml"
    namespace Rails.env
  end
end
