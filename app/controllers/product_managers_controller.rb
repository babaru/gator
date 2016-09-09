class ProductManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_manager, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /product_managers
  # GET /product_managers.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:product_manager])
      redirect_to product_managers_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_product_manager_params

    @conditions = []
    @conditions << ProductManager.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_product_managers_grid(@conditions) }
      format.json { render json: ProductManager.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_product_manager_params
    @query_product_manager_params = ProductManager.new
    QUERY_KEYS.each do |key|
      @query_product_manager_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /product_managers/1
  # GET /product_managers/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /product_managers/new
  def new
    @product_manager = ProductManager.new
  end

  # GET /product_managers/1/edit
  def edit
  end

  # POST /product_managers
  # POST /product_managers.json
  def create
    @product_manager = ProductManager.new(product_manager_params)

    respond_to do |format|
      if @product_manager.save
        set_product_managers_grid
        format.html { redirect_to @product_manager, notice: t('activerecord.success.messages.created', model: ProductManager.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /product_managers/1
  # PATCH/PUT /product_managers/1.json
  def update
    respond_to do |format|
      if @product_manager.update(product_manager_params)
        set_product_managers_grid
        format.html { redirect_to @product_manager, notice: t('activerecord.success.messages.updated', model: ProductManager.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /product_managers/1
  # DELETE /product_managers/1.json
  def destroy
    @product_manager.destroy

    respond_to do |format|
      set_product_managers_grid
      format.html { redirect_to product_managers_url, notice: t('activerecord.success.messages.destroyed', model: ProductManager.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_manager
    @product_manager = ProductManager.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_manager_params
    params.require(:product_manager).permit(
      :name,
      )
  end

  def set_product_managers_grid(conditions = [])
    @product_managers_grid = initialize_grid(ProductManager.where(conditions))
  end
end
