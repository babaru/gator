class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @query_params = {}

    if request.post?
      @query_params[:name] = params[:product][:name] if params[:product][:name] && !params[:product][:name].empty?
    end

    @query_product_params = Product.new
    @query_product_params.name = @query_params[:name]

    @conditions = []
    @conditions << Product.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Product.arel_table[:short_name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    set_products_grid(@conditions)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @clients_grid = initialize_grid(Client)
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.build_product_manager
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        set_products_grid
        format.html { redirect_to @product, notice: t('activerecord.success.messages.created', model: Product.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        set_products_grid
        format.html { redirect_to @product, notice: t('activerecord.success.messages.updated', model: Product.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      set_products_grid
      format.html { redirect_to products_url, notice: t('activerecord.success.messages.destroyed', model: Product.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(
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

  def set_products_grid(conditions = [])
    @products_grid = initialize_grid(Product.where(conditions))
  end
end
