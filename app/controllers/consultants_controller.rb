

class ConsultantsController < ApplicationController
  before_action :set_consultant, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /consultants
  # GET /consultants.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:consultant])
      redirect_to consultants_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_consultant_params

    @conditions = []
    @conditions << Consultant.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_consultants_grid(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_consultant_params
    @query_consultant_params = Consultant.new
    QUERY_KEYS.each do |key|
      @query_consultant_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /consultants/1
  # GET /consultants/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /consultants/new
  def new
    @consultant = Consultant.new
  end

  # GET /consultants/1/edit
  def edit
  end

  # POST /consultants
  # POST /consultants.json
  def create
    @consultant = Consultant.new(consultant_params)

    respond_to do |format|
      if @consultant.save
        set_consultants_grid
        format.html { redirect_to @consultant, notice: t('activerecord.success.messages.created', model: Consultant.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /consultants/1
  # PATCH/PUT /consultants/1.json
  def update
    respond_to do |format|
      if @consultant.update(consultant_params)
        set_consultants_grid
        format.html { redirect_to @consultant, notice: t('activerecord.success.messages.updated', model: Consultant.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /consultants/1
  # DELETE /consultants/1.json
  def destroy
    @consultant.destroy

    respond_to do |format|
      set_consultants_grid
      format.html { redirect_to consultants_url, notice: t('activerecord.success.messages.destroyed', model: Consultant.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_consultant
    @consultant = Consultant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def consultant_params
    params.require(:consultant).permit(
      :name,
      :department_id,
      )
  end

  def set_consultants_grid(conditions = [])
    @consultants_grid = initialize_grid(Consultant.where(conditions))
  end
end


