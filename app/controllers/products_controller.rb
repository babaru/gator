class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name, :consultant_name].freeze

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

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    set_products_grid(@conditions)
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

  # GET /products/1
  # GET /products/1.json
  def show
    @clients_grid = initialize_grid(Client)
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.build_product_manager
    @product.build_sales_department
    @product.build_operation_department
    @product.build_consultant_reference_department
    @product.build_consultant
  end

  # GET /products/1/edit
  def edit
    @product.build_product_manager if @product.product_manager.nil?
    @product.build_sales_department if @product.sales_department.nil?
    @product.build_operation_department if @product.operation_department.nil?
    @product.build_consultant_reference_department if @product.consultant_reference_department.nil?
    @product.build_consultant if @product.consultant.nil?
  end

  # POST /products
  # POST /products.json
  def create
    respond_to do |format|
      @product = Product.new(product_params.except(:product_manager_attributes,
        :sales_department_attributes,
        :operation_department_attributes,
        :consultant_reference_department_attributes,
        :consultant_attributes))
      @product.product_manager = ProductManager.find_or_create_by(name: product_params[:product_manager_attributes][:name])
      @product.sales_department = Department.find_or_create_by(name: product_params[:sales_department_attributes][:name])
      @product.operation_department = Department.find_or_create_by(name: product_params[:operation_department_attributes][:name])
      @product.consultant_reference_department =
        Department.find_or_create_by(name: product_params[:consultant_reference_department_attributes][:name])
      @product.consultant = Consultant.find_or_create_by(name: product_params[:consultant_attributes][:name])

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
      @product.product_manager = ProductManager.find_or_create_by(name: product_params[:product_manager_attributes][:name])
      @product.sales_department = Department.find_or_create_by(name: product_params[:sales_department_attributes][:name])
      @product.operation_department = Department.find_or_create_by(name: product_params[:operation_department_attributes][:name])
      @product.consultant_reference_department =
        Department.find_or_create_by(name: product_params[:consultant_reference_department_attributes][:name])
      @product.consultant = Consultant.find_or_create_by(name: product_params[:consultant_attributes][:name])

      if @product.update(product_params.except(:product_manager_attributes,
        :sales_department_attributes,
        :operation_department_attributes,
        :consultant_reference_department_attributes,
        :consultant_attributes))
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
      :code,
      :running_status,
      :product_type,
      :product_dev_type,
      :initial_fund,
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
      product_manager_attributes: [
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
      consultant_reference_department_attributes: [
        :id,
        :name
      ],
      consultant_attributes: [
        :id,
        :name
      ],
      trustor_bank_account_attributes: [
        :number, :name,
        trustor_attributes: [
          :id,
          :name
        ],
        bank_attributes: [
          :id,
          :name
        ]
      ],
      securities_broker_account_attributes: [
        :number, :name,
        securities_broker_attributes: [
          :name
        ]
      ]
      )
  end

  def set_products_grid(conditions = [])
    @products_grid = initialize_grid(Product.where(conditions))
  end
end
