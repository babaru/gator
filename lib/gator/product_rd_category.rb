module Gator
  class ProductRDCategory < ::Settingslogic
    source "#{Rails.root}/config/gator/product_rd_categories.yml"
    namespace Rails.env
  end
end
