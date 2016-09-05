

class TrustorsController < ApplicationController
  before_action :set_trustor, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /trustors
  # GET /trustors.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:trustor])
      redirect_to trustors_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_trustor_params

    @conditions = []
    @conditions << Trustor.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_trustors_grid(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_trustor_params
    @query_trustor_params = Trustor.new
    QUERY_KEYS.each do |key|
      @query_trustor_params.send("#{key}=", @query_params[key])
    end
  end

  # GET /trustors/1
  # GET /trustors/1.json
  def show
  end

  # GET /trustors/new
  def new
    @trustor = Trustor.new
  end

  # GET /trustors/1/edit
  def edit
  end

  # POST /trustors
  # POST /trustors.json
  def create
    @trustor = Trustor.new(trustor_params)

    respond_to do |format|
      if @trustor.save
        set_trustors_grid
        format.html { redirect_to @trustor, notice: t('activerecord.success.messages.created', model: Trustor.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /trustors/1
  # PATCH/PUT /trustors/1.json
  def update
    respond_to do |format|
      if @trustor.update(trustor_params)
        set_trustors_grid
        format.html { redirect_to @trustor, notice: t('activerecord.success.messages.updated', model: Trustor.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /trustors/1
  # DELETE /trustors/1.json
  def destroy
    @trustor.destroy

    respond_to do |format|
      set_trustors_grid
      format.html { redirect_to trustors_url, notice: t('activerecord.success.messages.destroyed', model: Trustor.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trustor
    @trustor = Trustor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trustor_params
    params.require(:trustor).permit(
      :name,
      )
  end

  def set_trustors_grid(conditions = [])
    @trustors_grid = initialize_grid(Trustor.where(conditions))
  end
end


