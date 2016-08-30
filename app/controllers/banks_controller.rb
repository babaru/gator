class BanksController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Bank.all }
    end
  end
end
