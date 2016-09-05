

class SecuritiesBrokersController < ApplicationController
  before_action :set_securities_broker, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /securities_brokers
  # GET /securities_brokers.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:securities_broker])
      redirect_to securities_brokers_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_securities_broker_params

    @conditions = []
    @conditions << SecuritiesBroker.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_securities_brokers_grid(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_securities_broker_params
    @query_securities_broker_params = SecuritiesBroker.new
    QUERY_KEYS.each do |key|
      @query_securities_broker_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /securities_brokers/1
  # GET /securities_brokers/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /securities_brokers/new
  def new
    @securities_broker = SecuritiesBroker.new
  end

  # GET /securities_brokers/1/edit
  def edit
  end

  # POST /securities_brokers
  # POST /securities_brokers.json
  def create
    @securities_broker = SecuritiesBroker.new(securities_broker_params)

    respond_to do |format|
      if @securities_broker.save
        set_securities_brokers_grid
        format.html { redirect_to @securities_broker, notice: t('activerecord.success.messages.created', model: SecuritiesBroker.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /securities_brokers/1
  # PATCH/PUT /securities_brokers/1.json
  def update
    respond_to do |format|
      if @securities_broker.update(securities_broker_params)
        set_securities_brokers_grid
        format.html { redirect_to @securities_broker, notice: t('activerecord.success.messages.updated', model: SecuritiesBroker.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /securities_brokers/1
  # DELETE /securities_brokers/1.json
  def destroy
    @securities_broker.destroy

    respond_to do |format|
      set_securities_brokers_grid
      format.html { redirect_to securities_brokers_url, notice: t('activerecord.success.messages.destroyed', model: SecuritiesBroker.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_securities_broker
    @securities_broker = SecuritiesBroker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def securities_broker_params
    params.require(:securities_broker).permit(
      :name,
      )
  end

  def set_securities_brokers_grid(conditions = [])
    @securities_brokers_grid = initialize_grid(SecuritiesBroker.where(conditions))
  end
end


