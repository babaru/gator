require 'rails_helper'

RSpec.describe "ProductDiffs", type: :request do
  describe "GET /product_diffs" do
    it "works! (now write some real specs)" do
      get product_diffs_path
      expect(response).to have_http_status(200)
    end
  end
end
