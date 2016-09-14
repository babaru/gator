module Gator
  class ProductStatus < ::Settingslogic
    source "#{Rails.root}/config/gator/product_statuses.yml"
    namespace Rails.env
  end
end
