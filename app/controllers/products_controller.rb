class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy, :edit_tab]

  QUERY_KEYS = [:name, :consultant_name,
    :delegation_started_at, :delegation_ended_at, :categories, :tag_names, :remarks].freeze
  TABS = [:summary, :clients].freeze

  ARRAY_SP = ","
  ARRAY_HEADER = "a_"

  # GET /products
  # GET /products.json
  def index
    @query_params = {}

    build_query_params(params)
    build_query_product_params

    @conditions = []
    @conditions << Product.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Product.arel_table[:short_name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Product.arel_table[:consultant_name].matches("%#{@query_params[:consultant_name]}%") if @query_params[:consultant_name]
    @conditions << Product.arel_table[:delegation_started_at].lteq(Time.parse(@query_params[:delegation_started_at]).beginning_of_day) if @query_params[:delegation_started_at]
    @conditions << Product.arel_table[:delegation_ended_at].gteq(Time.parse(@query_params[:delegation_ended_at]).beginning_of_day) if @query_params[:delegation_ended_at]
    @query_params[:categories] && @query_params[:categories].gsub(ARRAY_HEADER, "").split(ARRAY_SP).each do |category|
      @conditions << Product.arel_table[:category].eq(category) unless category.empty?
    end
    @conditions << Product.arel_table[:tag_names].matches("%#{@query_params[:tag_names]}%") if @query_params[:tag_names]
    @conditions << Product.arel_table[:remarks].matches("%#{@query_params[:remarks]}%") if @query_params[:remarks]

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

  def search
    @query_params = {}
    if request.post?
      build_query_params(params[:product])
      redirect_to products_path(@query_params)
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      if parameters[key].is_a?(Array)
        @query_params[key] = "a_#{parameters[key].join(ARRAY_SP)}"
      else
        @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
      end
    end
  end

  def build_query_product_params
    @query_product_params = Product.new
    QUERY_KEYS.each do |key|
      if @query_params[key] && @query_params[key].start_with?(ARRAY_HEADER)
        @query_product_params.send("#{key}=", @query_params[key].gsub(ARRAY_HEADER, "").split(ARRAY_SP))
      else
        @query_product_params.send("#{key}=", @query_params[key])
      end
    end
  end

  def import_from_excel
    if request.post?
      @product_import_excel_file = ProductImportExcelFile.new(product_import_excel_file_params)
      if @product_import_excel_file.save
        products_data = Gator::ProductsExcelImporter.parse(@product_import_excel_file.file.path)
        logger.debug products_data
        sheet_data = products_data[0] # one to one
        sheet_data[:data].each do |product_data|
          product_name = product_data[1]
          product = Product.find_by_name(product_name) if product_name
          next if product
          staff = Staff.find_by_name(product_data[4]) if product_data[4]

          product = Product.new({
            name: product_name,
            client_code: product_data[2],
            short_name: product_data[3].nil? ? product_name : product_data[3],
            staff: staff,
            code: product_data[5] ,
            status: Gator::ProductStatus.product_statuses.running,
            category: Gator::ProductCategory.product_categories.future,
            rd_category: Gator::ProductRDCategory.product_rd_categories.self_management,
            is_structured: false,
            is_one_to_many: false,
            initial_fund: product_data[9].nil? ? 0: product_data[9],
            trustor_name: product_data[10],
            trustor_bank_name: product_data[11],
            securities_broker_name: product_data[12],
            valuation_out_sourcing: product_data[13],
            deposited_at: product_data[14].is_a?(DateTime) ? product_data[14] : DateTime.new(2000,1,1),
            delegation_started_at: product_data[15].is_a?(DateTime) ? product_data[15] : DateTime.new(2000,1,1),
            delegation_ended_at: product_data[16].is_a?(DateTime) ? product_data[16] : DateTime.new(2000,1,1),
            delegation_duration: product_data[17],
            contract_profit_ratio: product_data[18],
            spec_profit_ratio: product_data[19],
            fee_calculation_standard: product_data[20],
            management_fee_ratio: product_data[21],
            year_day_count: product_data[22],
            management_fee_flour: product_data[23],
            trustor_fee_ratio: product_data[24],
            operation_fee_ratio: product_data[25],
            consultant_fee_ratio: product_data[26],
            consultant_fee_flour: product_data[27],
            bonus: product_data[28],
            sales_fee_ratio: product_data[29],
            sse_account_code: product_data[30],
            szse_account_code: product_data[31],
            cffex_account_code: product_data[32],
            zce_account_code: product_data[33],
            dce_account_code: product_data[34],
            shfe_account_code: product_data[35]
          })
          logger.debug product.errors.full_messages unless product.save
        end

        sheet_data = products_data[1] # one to many
        sheet_data[:data].each do |product_data|
          product_name = product_data[1]
          product = Product.find_by_name(product_name) if product_name
          next if product

          staff = Staff.find_by_name(product_data[6]) if product_data[6]

          product = Product.new({
            name: product_name,
            client_code: product_data[2],
            short_name: product_data[3].nil? ? product_name : product_data[3],
            staff: staff,
            code: product_data[7],
            status: Gator::ProductStatus.product_statuses.running,
            category: Gator::ProductCategory.product_categories.future,
            rd_category: Gator::ProductRDCategory.product_rd_categories.self_management,
            is_structured: (product_data[4].nil? || product_data[4].blank? || product_data[4] == '否') ? false : true,
            is_one_to_many: true,
            leverage: product_data[5],
            initial_fund: product_data[11].nil? ? 0 : product_data[11],
            trustor_name: product_data[12],
            trustor_bank_name: product_data[14],
            trustor_bank_account_name: product_data[13],
            trustor_bank_account_number: product_data[15],
            securities_broker_name: product_data[17],
            securities_broker_account_name: product_data[16],
            securities_broker_account_number: product_data[18],
            valuation_out_sourcing: product_data[19],
            deposited_at: product_data[20].is_a?(DateTime) ? product_data[20] : DateTime.new(2000,1,1),
            delegation_started_at: product_data[21].is_a?(DateTime) ? product_data[21] : DateTime.new(2000,1,1),
            delegation_ended_at: product_data[22].is_a?(DateTime) ? product_data[22] : DateTime.new(2000,1,1),
            delegation_duration: product_data[23],
            fee_calculation_standard: product_data[24],
            management_fee_ratio: product_data[25],
            year_day_count: product_data[26],
            management_fee_flour: product_data[27],
            trustor_fee_ratio: product_data[28],
            operation_fee_ratio: product_data[29],
            consultant_fee_ratio: product_data[30],
            consultant_fee_flour: product_data[31],
            bonus: product_data[32],
            sales_fee_ratio: product_data[33],
            sse_gateway: product_data[34],
            szse_gateway: product_data[35],
            sse_account_code: product_data[36],
            szse_account_code: product_data[37],
            cffex_account_code: product_data[38],
            zce_account_code: product_data[39],
            dce_account_code: product_data[40],
            shfe_account_code: product_data[41]
          })
          logger.debug product.errors.full_messages unless product.save
        end
      end

      redirect_to products_path
    else
      @product_import_excel_file = ProductImportExcelFile.new
    end
  end

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
    @product.tags.clear
    product_params[:tag_names].split(',').each do |tag_name|
      tag = Tag.find_or_create_by({name: tag_name})
      @product.tags << tag
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
      :status,
      :liquidated_at,
      :category,
      :rd_category,
      :is_structured,
      :is_one_to_many,
      :investment_scope,
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
      :contract_profit_ratio,
      :spec_profit_ratio,
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
      :tag_names,
      :remarks,
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

  def product_import_excel_file_params
    params.require(:product_import_excel_file).permit(:file)
  end

  def set_products_grid(conditions = [])
    @products_grid = initialize_grid(Product.where(conditions))
  end
end
