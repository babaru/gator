FactoryGirl.define do
  factory :test_product_1, class: Product do
    name 'Test Product 1'
    short_name 'TP1'
    client_code 'Client Code of Test Product 1'
    code 'TP1-code'
    status Gator::ProductStatus.product_statuses.running
    category Gator::ProductCategory.product_categories.future
    rd_category Gator::ProductRDCategory.product_rd_categories.self_management
    initial_fund 10000000000
    deposited_at Time.now
    delegation_started_at Time.now
    delegation_ended_at 3.years.since(Time.now)
  end

  factory :test_product_2, class: Product do
    name 'Test Product 2'
    short_name 'TP2'
    client_code 'Client Code of Test Product 2'
    code 'TP2-code'
    status Gator::ProductStatus.product_statuses.running
    category Gator::ProductCategory.product_categories.future
    rd_category Gator::ProductRDCategory.product_rd_categories.self_management
    initial_fund 10000000000
    deposited_at Time.now
    delegation_started_at Time.now
    delegation_ended_at 3.years.since(Time.now)
  end

  factory :test_product_3, class: Product do
    name 'Test Product 3'
    short_name 'TP3'
    client_code 'Client Code of Test Product 3'
    code 'TP3-code'
    status Gator::ProductStatus.product_statuses.running
    category Gator::ProductCategory.product_categories.future
    rd_category Gator::ProductRDCategory.product_rd_categories.self_management
    initial_fund 10000000000
    deposited_at Time.now
    delegation_started_at Time.now
    delegation_ended_at 3.years.since(Time.now)
  end
end
