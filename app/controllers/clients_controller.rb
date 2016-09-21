class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  ARRAY_SP = ","
  ARRAY_HEADER = "a_"

  QUERY_KEYS = [:name, :application_number, :id_number, :categories].freeze
  TABS = [:summary, :extra_information, :original_materials, :products].freeze

  # GET /clients
  # GET /clients.json
  def index
    @query_params = {}

    build_query_params(params)
    build_query_entity_params

    @conditions = []
    @conditions << Client.arel_table[:application_number].matches("%#{@query_params[:application_number]}%") if @query_params[:application_number]
    @conditions << Client.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Client.arel_table[:id_number].matches("%#{@query_params[:id_number]}%") if @query_params[:id_number]
    @query_params[:categories] && @query_params[:categories].gsub(ARRAY_HEADER, "").split(ARRAY_SP).each do |category|
      @conditions << Client.arel_table[:category].eq(category) unless category.empty?
    end

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_clients_grid(@conditions) }
      format.json { render json: Client.where(@conditions) }
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

  def build_query_entity_params
    @query_entity_params = Client.new
    QUERY_KEYS.each do |key|
      if @query_params[key] && @query_params[key].start_with?(ARRAY_HEADER)
        @query_entity_params.send("#{key}=", @query_params[key].gsub(ARRAY_HEADER, "").split(ARRAY_SP))
      else
        @query_entity_params.send("#{key}=", @query_params[key])
      end
    end
  end

  def search
    @query_params = {}
    if request.post?
      build_query_params(params[:client])
      redirect_to clients_path(@query_params)
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @tabs = TABS
    get_current_tab
    @product_shares_grid = initialize_grid(ProductShare.where(client_id: @client.id)) if @current_tab == :products
  end

  def get_current_tab
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        set_clients_grid
        format.html { redirect_to @client.becomes(Client), notice: t('activerecord.success.messages.created', model: Client.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        set_clients_grid
        format.html { redirect_to @client.becomes(Client), notice: t('activerecord.success.messages.updated', model: Client.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy

    respond_to do |format|
      set_clients_grid
      format.html { redirect_to clients_url, notice: t('activerecord.success.messages.destroyed', model: Client.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(
      :category,
      :application_number,
      :id_number_type,
      :id_number,
      :name,
      :traded_at,
      :person_in_charge_id_number_type,
      :person_in_charge_id_number,
      :person_in_charge_name,
      :fund_trading_account_number,
      :sales_man_code,
      :business_code,
      :branch_store_number,
      :fund_account_number,
      )
  end

  def set_clients_grid(conditions = [])
    @clients_grid = initialize_grid(Client.where(conditions))
  end
end
