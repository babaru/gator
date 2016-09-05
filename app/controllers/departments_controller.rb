

class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /departments
  # GET /departments.json
  def index
    @query_params = {}

    if request.post?
      build_query_params(params[:department])
      redirect_to departments_path(@query_params)
    else
      build_query_params(params)
    end

    build_query_department_params

    @conditions = []
    @conditions << Department.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_departments_grid(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_department_params
    @query_department_params = Department.new
    QUERY_KEYS.each do |key|
      @query_department_params.send("#{key}=", @query_params[key])
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /departments/1
  # GET /departments/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        set_departments_grid
        format.html { redirect_to @department, notice: t('activerecord.success.messages.created', model: Department.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        set_departments_grid
        format.html { redirect_to @department, notice: t('activerecord.success.messages.updated', model: Department.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy

    respond_to do |format|
      set_departments_grid
      format.html { redirect_to departments_url, notice: t('activerecord.success.messages.destroyed', model: Department.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = Department.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def department_params
    params.require(:department).permit(
      :name,
      )
  end

  def set_departments_grid(conditions = [])
    @departments_grid = initialize_grid(Department.where(conditions))
  end
end


