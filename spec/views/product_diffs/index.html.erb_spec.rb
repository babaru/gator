require 'rails_helper'

RSpec.describe "product_diffs/index", type: :view do
  before(:each) do
    assign(:product_diffs, [
      ProductDiff.create!(),
      ProductDiff.create!()
    ])
  end

  it "renders a list of product_diffs" do
    render
  end
end
