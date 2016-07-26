


class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
  def index
    set_assets_grid
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = Asset.new
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(asset_params)

    respond_to do |format|
      if @asset.save
        set_assets_grid
        format.html { redirect_to @asset, notice: t('activerecord.success.messages.created', model: Asset.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        set_assets_grid
        format.html { redirect_to @asset, notice: t('activerecord.success.messages.updated', model: Asset.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy

    respond_to do |format|
      set_assets_grid
      format.html { redirect_to assets_url, notice: t('activerecord.success.messages.destroyed', model: Asset.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_asset
    @asset = Asset.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def asset_params
    params.require(:asset).permit(
      :name,
      :client_code,
      :short_name,
      :manager_name,
      :code,
      :running_status,
      :type,
      :dev_type,
      :initial_fund,
      :trustor_name,
      :trustor_account_name,
      :trustor_bank_name,
      :trustor_bank_account,
      :securities_account_name,
      :securities_bank_name,
      :securities_capital_account,
      :valuation_out_sourcing,
      :deposited_at,
      :delegation_started_at,
      :delegation_ended_at,
      :delegation_duration,
      :fee_calculation_standard,
      :management_fee_ratio,
      :year_day_count,
      :management_fee_flour,
      :trustor_fee_ratio,
      :operation_fee_ratio,
      :investment_consultant_fee_ratio,
      :investment_consultant_fee_flour,
      :bonus,
      :sales_fee_ratio,
      :sse_account_code,
      :szse_account_code,
      :cffex_account_code,
      :zce_account_code,
      :dce_account_code,
      :shfe_account_code,
      :sales_department,
      :investment_consultant_reference_department,
      :operation_department,
      :investment_consultant_name,
      :sse_gateway,
      :szse_gateway,
      )
  end

  def set_assets_grid
    @assets_grid = initialize_grid(Asset)
  end
end


