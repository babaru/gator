

class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /banks
  # GET /banks.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:bank])
      redirect_to banks_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_bank_params

    @conditions = []
    @conditions << Bank.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_banks_grid(@conditions) }
      format.json { render json: Bank.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_bank_params
    @query_bank_params = Bank.new
    QUERY_KEYS.each do |key|
      @query_bank_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /banks/1
  # GET /banks/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)

    respond_to do |format|
      if @bank.save
        set_banks_grid
        format.html { redirect_to @bank, notice: t('activerecord.success.messages.created', model: Bank.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    respond_to do |format|
      if @bank.update(bank_params)
        set_banks_grid
        format.html { redirect_to @bank, notice: t('activerecord.success.messages.updated', model: Bank.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy

    respond_to do |format|
      set_banks_grid
      format.html { redirect_to banks_url, notice: t('activerecord.success.messages.destroyed', model: Bank.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bank
    @bank = Bank.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bank_params
    params.require(:bank).permit(
      :name,
      )
  end

  def set_banks_grid(conditions = [])
    @banks_grid = initialize_grid(Bank.where(conditions))
  end
end


