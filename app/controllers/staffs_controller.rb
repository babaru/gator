

class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  QUERY_KEYS = [:name].freeze

  # GET /staffs
  # GET /staffs.json
  def index
    @query_params = {}

    build_query_params(params)
    build_query_staff_params

    @conditions = []
    @conditions << Staff.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_staffs_grid(@conditions) }
      format.json { render json: Staff.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_staff_params
    @query_staff_params = Staff.new
    QUERY_KEYS.each do |key|
      @query_staff_params.send("#{key}=", @query_params[key])
    end
  end

  def search
    @query_params = {}
    if request.post?
      build_query_params(params[:staff])
      redirect_to staffs_path(@query_params)
    end
  end

  TABS = [:products].freeze

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym

    if @current_tab == :products
      @products_grid = initialize_grid(Product.where(staff_id: @staff.id))
    end
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
    @staff.build_department
  end

  # GET /staffs/1/edit
  def edit
    @staff.build_department if @staff.department.nil?
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params.except(:department_attributes))
    @staff.department = Department.find_or_create_by(name: staff_params[:department_attributes][:name])

    respond_to do |format|
      if @staff.save
        set_staffs_grid
        format.html { redirect_to staffs_path, notice: t('activerecord.success.messages.created', model: Staff.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      @staff.department = Department.find_or_create_by(name: staff_params[:department_attributes][:name])
      if @staff.update(staff_params.except(:department_attributes))
        set_staffs_grid
        format.html { redirect_to staffs_path, notice: t('activerecord.success.messages.updated', model: Staff.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy

    respond_to do |format|
      set_staffs_grid
      format.html { redirect_to staffs_url, notice: t('activerecord.success.messages.destroyed', model: Staff.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_staff
    @staff = Staff.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def staff_params
    params.require(:staff).permit(
      :name,
      :department_id,
      :position,
      :duration,
      :office_tel,
      :email,
      :mobile,
      :resume,
      :is_investment_manager,
      :certification_id,
      :user_id,
      :department_attributes => [
        :name,
        :id
      ],
      )
  end

  def set_staffs_grid(conditions = [])
    @staffs_grid = initialize_grid(Staff.where(conditions))
  end
end
