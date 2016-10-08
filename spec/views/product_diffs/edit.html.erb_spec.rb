require 'rails_helper'

RSpec.describe "product_diffs/edit", type: :view do
  before(:each) do
    @product_diff = assign(:product_diff, ProductDiff.create!())
  end

  it "renders the edit product_diff form" do
    render

    assert_select "form[action=?][method=?]", product_diff_path(@product_diff), "post" do
    end
  end
end
