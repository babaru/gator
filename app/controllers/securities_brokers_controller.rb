class SecuritiesBrokersController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: SecuritiesBroker.all }
    end
  end
end
