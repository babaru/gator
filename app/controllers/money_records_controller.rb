

class MoneyRecordsController < ApplicationController
  before_action :set_money_record, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /money_records
  # GET /money_records.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:money_record])
      redirect_to money_records_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_money_record_params

    @conditions = []
    @conditions << MoneyRecord.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_money_records_grid(@conditions) }
      format.json { render json: MoneyRecord.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_money_record_params
    @query_money_record_params = MoneyRecord.new
    QUERY_KEYS.each do |key|
      @query_money_record_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /money_records/1
  # GET /money_records/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /money_records/new
  def new
    @money_record = MoneyRecord.new
  end

  # GET /money_records/1/edit
  def edit
  end

  # POST /money_records
  # POST /money_records.json
  def create
    @money_record = MoneyRecord.new(money_record_params)

    respond_to do |format|
      if @money_record.save
        set_money_records_grid
        format.html { redirect_to @money_record, notice: t('activerecord.success.messages.created', model: MoneyRecord.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /money_records/1
  # PATCH/PUT /money_records/1.json
  def update
    respond_to do |format|
      if @money_record.update(money_record_params)
        set_money_records_grid
        format.html { redirect_to @money_record, notice: t('activerecord.success.messages.updated', model: MoneyRecord.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /money_records/1
  # DELETE /money_records/1.json
  def destroy
    @money_record.destroy

    respond_to do |format|
      set_money_records_grid
      format.html { redirect_to money_records_url, notice: t('activerecord.success.messages.destroyed', model: MoneyRecord.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_money_record
    @money_record = MoneyRecord.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def money_record_params
    params.require(:money_record).permit(
      :done_at,
      :type,
      :amount,
      :staff_id,
      :product_id,
      )
  end

  def set_money_records_grid(conditions = [])
    @money_records_grid = initialize_grid(MoneyRecord.where(conditions))
  end
end


