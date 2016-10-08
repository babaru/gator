require "rails_helper"

RSpec.describe ProductDiffsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/product_diffs").to route_to("product_diffs#index")
    end

    it "routes to #new" do
      expect(:get => "/product_diffs/new").to route_to("product_diffs#new")
    end

    it "routes to #show" do
      expect(:get => "/product_diffs/1").to route_to("product_diffs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_diffs/1/edit").to route_to("product_diffs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/product_diffs").to route_to("product_diffs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/product_diffs/1").to route_to("product_diffs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/product_diffs/1").to route_to("product_diffs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_diffs/1").to route_to("product_diffs#destroy", :id => "1")
    end

  end
end
