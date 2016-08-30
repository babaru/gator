class TrustorsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Trustor.all }
    end
  end

  def bank_accounts
    respond_to do |format|
      trustor = Trustor.find(params[:trustor_id])
      if trustor
        format.json { render json: trustor.trustor_bank_accounts.where(bank_id: params[:bank_id]) }
      else
        format.json { render json: [] }
      end
    end
  end
end
