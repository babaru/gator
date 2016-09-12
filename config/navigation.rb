# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  #navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'active'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  #navigation.active_leaf_class = 'simple-navigation-active-leaf'

  # Specify if item keys are added to navigation items as id. Defaults to true
  #navigation.autogenerate_item_ids = true

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  #navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that
  # will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  #navigation.name_generator = Proc.new {|name, item| "<span>#{name}</span>"}

  # Specify if the auto highlight feature is turned on (globally, for the whole navigation). Defaults to true
  navigation.auto_highlight = true

  # Specifies whether auto highlight should ignore query params and/or anchors when
  # comparing the navigation items with the current URL. Defaults to true
  #navigation.ignore_query_params_on_auto_highlight = true
  #navigation.ignore_anchors_on_auto_highlight = true

  # If this option is set to true, all item names will be considered as safe (passed through html_safe). Defaults to false.
  #navigation.consider_item_names_as_safe = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :users, User.model_name.human, users_path if can? :manage, User
    primary.item :staffs, Staff.model_name.human, staffs_path if can? :read, Staff
    primary.item :products, Product.model_name.human, products_path if can? :read, Product
    primary.item :clients, Client.model_name.human, clients_path if can? :read, Client
    primary.item :consultants, Consultant.model_name.human, consultants_path if can? :read, Consultant
    primary.item :departments, Department.model_name.human, departments_path if can? :read, Department
    primary.item :trustors, Trustor.model_name.human, trustors_path if can? :read, Trustor
    primary.item :banks, Bank.model_name.human, banks_path if can? :read, Bank
    primary.item :securities_brokers, SecuritiesBroker.model_name.human, securities_brokers_path if can? :read, SecuritiesBroker
  end
end
