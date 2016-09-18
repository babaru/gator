

class ProductSharesController < ApplicationController
  before_action :set_product_share, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /product_shares
  # GET /product_shares.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:product_share])
      redirect_to product_shares_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_product_share_params

    @conditions = []
    @conditions << ProductShare.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_product_shares_grid(@conditions) }
      format.json { render json: ProductShare.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_product_share_params
    @query_product_share_params = ProductShare.new
    QUERY_KEYS.each do |key|
      @query_product_share_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /product_shares/1
  # GET /product_shares/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /product_shares/new
  def new
    @product_share = ProductShare.new
    @product_share.build_product
    @product_share.build_client
    @product_share.product_id = params[:product_id] unless params[:product_id].nil?
    @product_share.client_id = params[:client_id] unless params[:client_id].nil?
  end

  # GET /product_shares/1/edit
  def edit
  end

  # POST /product_shares
  # POST /product_shares.json
  def create
    @product_share = ProductShare.new(product_share_params)

    respond_to do |format|
      if @product_share.save
        set_product_shares_grid
        format.html { redirect_to @product_share, notice: t('activerecord.success.messages.created', model: ProductShare.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /product_shares/1
  # PATCH/PUT /product_shares/1.json
  def update
    respond_to do |format|
      if @product_share.update(product_share_params)
        set_product_shares_grid
        format.html { redirect_to @product_share, notice: t('activerecord.success.messages.updated', model: ProductShare.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /product_shares/1
  # DELETE /product_shares/1.json
  def destroy
    @product_share.destroy

    respond_to do |format|
      set_product_shares_grid
      format.html { redirect_to product_shares_url, notice: t('activerecord.success.messages.destroyed', model: ProductShare.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_share
    @product_share = ProductShare.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_share_params
    params.require(:product_share).permit(
      :product_id,
      :client_id,
      :share,
      :product_attributes => [
        :id, :name
      ],
      :client_attributes => [
        :id, :name
      ]
      )
  end

  def set_product_shares_grid(conditions = [])
    @product_shares_grid = initialize_grid(ProductShare.where(conditions))
  end
end
