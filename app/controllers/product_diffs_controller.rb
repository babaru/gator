

class ProductDiffsController < ApplicationController
  before_action :set_product_diff, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze
  ARRAY_SP = ","
  ARRAY_HEADER = "a_"

  TABS = [:tab1, :tab2].freeze

  # GET /product_diffs
  # GET /product_diffs.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:product_diff])
      redirect_to product_diffs_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_product_diff_params

    @conditions = []
    @conditions << ProductDiff.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_product_diffs_grid(@conditions) }
      format.json { render json: ProductDiff.where(@conditions) }
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

  def build_query_product_diff_params
    @query_product_diff_params = ProductDiff.new
    QUERY_KEYS.each do |key|
      if @query_params[key] && @query_params[key].start_with?(ARRAY_HEADER)
        @query_product_diff_params.send("#{key}=", @query_params[key].gsub(ARRAY_HEADER, "").split(ARRAY_SP))
      else
        @query_product_diff_params.send("#{key}=", @query_params[key])
      end
    end
  end

  # GET /product_diffs/1
  # GET /product_diffs/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /product_diffs/new
  def new
    @product_diff = ProductDiff.new
  end

  # GET /product_diffs/1/edit
  def edit
  end

  # POST /product_diffs
  # POST /product_diffs.json
  def create
    @product_diff = ProductDiff.new(product_diff_params)

    respond_to do |format|
      if @product_diff.save
        set_product_diffs_grid
        format.html { redirect_to @product_diff, notice: t('activerecord.success.messages.created', model: ProductDiff.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /product_diffs/1
  # PATCH/PUT /product_diffs/1.json
  def update
    respond_to do |format|
      if @product_diff.update(product_diff_params)
        set_product_diffs_grid
        format.html { redirect_to @product_diff, notice: t('activerecord.success.messages.updated', model: ProductDiff.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /product_diffs/1
  # DELETE /product_diffs/1.json
  def destroy
    @product_diff.destroy

    respond_to do |format|
      set_product_diffs_grid
      format.html { redirect_to product_diffs_url, notice: t('activerecord.success.messages.destroyed', model: ProductDiff.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_diff
    @product_diff = ProductDiff.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_diff_params
    params.require(:product_diff).permit(
      :product_id,
      :diff_by_id,
      :diff_at,
      :diff,
      :is_committed,
      :committed_by_id,
      :committed_at,
      )
  end

  def set_product_diffs_grid(conditions = [])
    @product_diffs_grid = initialize_grid(ProductDiff.where(conditions))
  end
end


