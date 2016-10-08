FactoryGirl.define do
  factory :test_product_diff_1, class: ProductDiff do
    diff {{'name': 'Test Product 1 Diff', 'code': 'TP1-code Diff'}}
    is_committed false
  end
end
