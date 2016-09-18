module Gator
  class ClientCategory < ::Settingslogic
    source "#{Rails.root}/config/gator/client_categories.yml"
    namespace Rails.env
  end
end
