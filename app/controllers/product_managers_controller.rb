class ProductManagersController < ApplicationController

  # GET /product_managers.json
  def index
    respond_to do |format|
      format.json { render json: ProductManager.all }
    end
  end
end
