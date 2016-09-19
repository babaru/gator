class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy, :edit_tab]

  QUERY_KEYS = [:name, :consultant_name,
    :delegation_started_at, :delegation_ended_at].freeze

  # GET /products
  # GET /products.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:product])
      redirect_to products_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_product_params

    @conditions = []
    @conditions << Product.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Product.arel_table[:short_name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Product.arel_table[:consultant_name].matches("%#{@query_params[:consultant_name]}%") if @query_params[:consultant_name]
    @conditions << Product.arel_table[:delegation_started_at].lteq(Time.parse(@query_params[:delegation_started_at]).beginning_of_day) if @query_params[:delegation_started_at]
    @conditions << Product.arel_table[:delegation_ended_at].gteq(Time.parse(@query_params[:delegation_ended_at]).beginning_of_day) if @query_params[:delegation_ended_at]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_products_grid(@conditions) }
      format.xls { @products = Product.where(@conditions) }
      format.json { render json: Product.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_product_params
    @query_product_params = Product.new
    QUERY_KEYS.each do |key|
      @query_product_params.send("#{key}=", @query_params[key])
    end
  end

  def import_from_excel
    @product = Product.new
  end

  TABS = [:summary, :clients].freeze

  # GET /products/1
  # GET /products/1.json
  def show
    @tabs = TABS
    get_current_tab
    @product_shares_grid = initialize_grid(ProductShare.where(product_id: @product.id)) if @current_tab == :clients
  end

  def get_current_tab
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.build_staff
    @product.build_consultant
    @product.build_sales_department
    @product.build_operation_department
    @product.is_structured = false
    @product.status = Gator::ProductStatus.product_statuses.running
  end

  # GET /products/1/edit
  def edit
    get_current_tab
    @product.build_staff if @product.staff.nil?
    @product.build_consultant if @product.consultant.nil?
    @product.build_sales_department if @product.sales_department.nil?
    @product.build_operation_department if @product.operation_department.nil?
    @product.is_structured = false if @product.is_structured.nil?
    @product.status = Gator::ProductStatus.product_statuses.running if @product.status.nil?
  end

  # POST /products
  # POST /products.json
  def create
    respond_to do |format|
      @product = Product.new(product_params.except(:staff_attributes,
        :sales_department_attributes,
        :operation_department_attributes,
        :consultant_reference_department_attributes,
        :consultant_attributes))

      handle_associations(product_params)

      if @product.save
        set_products_grid
        format.html { redirect_to product_path(@product), notice: t('activerecord.success.messages.created', model: Product.model_name.human) }
        format.js
      else
        logger.debug @product.errors.full_messages
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      handle_associations(product_params)

      if @product.update(product_params.except(:staff_attributes,
        :sales_department_attributes,
        :operation_department_attributes,
        :consultant_reference_department_attributes,
        :consultant_attributes))
        set_products_grid
        format.html { redirect_to product_path(@product), notice: t('activerecord.success.messages.updated', model: Product.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  def handle_associations(product_params)
    @product.staff = Staff.find(product_params[:staff_attributes][:id]) if product_params[:staff_attributes] && !product_params[:staff_attributes][:id].empty?
    @product.sales_department = Department.find(product_params[:sales_department_attributes][:id]) if product_params[:sales_department_attributes] && !product_params[:sales_department_attributes][:id].empty?
    @product.operation_department = Department.find(product_params[:operation_department_attributes][:id]) if product_params[:operation_department_attributes] && !product_params[:operation_department_attributes][:id].empty?
    @product.consultant = Consultant.find(product_params[:consultant_attributes][:id]) if product_params[:consultant_attributes] && !product_params[:consultant_attributes][:id].empty?
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
      :code,
      :status,
      :liquidated_at,
      :category,
      :rd_category,
      :is_structured,
      :is_one_to_many,
      :superior_code,
      :inferior_code,
      :leverage,
      :initial_fund,
      :valuation_out_sourcing,
      :deposited_at,
      :put_on_record_at,
      :delegation_started_at,
      :delegation_ended_at,
      :delegation_duration,
      :fee_calculation_standard,
      :management_fee_ratio,
      :year_day_count,
      :management_fee_flour,
      :trustor_fee_ratio,
      :operation_fee_ratio,
      :consultant_fee_ratio,
      :consultant_fee_flour,
      :bonus,
      :sales_fee_ratio,
      :trustor_name,
      :trustor_bank_name,
      :trustor_bank_account_name,
      :trustor_bank_account_number,
      :securities_broker_name,
      :securities_broker_account_name,
      :securities_broker_account_number,
      :sse_account_code,
      :szse_account_code,
      :cffex_account_code,
      :zce_account_code,
      :dce_account_code,
      :shfe_account_code,
      :sales_department,
      :operation_department,
      :consultant_name,
      :sse_gateway,
      :szse_gateway,
      :cffex_gateway,
      :zce_gateway,
      :dce_gateway,
      :shfe_gateway,
      :sales_department,
      staff_attributes: [
        :id,
        :name
      ],
      sales_department_attributes: [
        :id,
        :name
      ],
      operation_department_attributes: [
        :id,
        :name
      ],
      consultant_attributes: [
        :id,
        :name
      ]
      )
  end

  def set_products_grid(conditions = [])
    @products_grid = initialize_grid(Product.where(conditions))
  end
end
