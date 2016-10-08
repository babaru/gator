require 'rails_helper'

RSpec.describe "product_diffs/new", type: :view do
  before(:each) do
    assign(:product_diff, ProductDiff.new())
  end

  it "renders new product_diff form" do
    render

    assert_select "form[action=?][method=?]", product_diffs_path, "post" do
    end
  end
end
