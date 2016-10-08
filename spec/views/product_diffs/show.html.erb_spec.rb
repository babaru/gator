require 'rails_helper'

RSpec.describe "product_diffs/show", type: :view do
  before(:each) do
    @product_diff = assign(:product_diff, ProductDiff.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
