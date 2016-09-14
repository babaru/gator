module Gator
  class ProductCategory < ::Settingslogic
    source "#{Rails.root}/config/gator/product_categories.yml"
    namespace Rails.env
  end
end
