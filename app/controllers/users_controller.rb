class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :upgrade_to_product_manager]

  QUERY_KEYS = [:login].freeze

  # GET /users
  # GET /users.json
  def index
    @query_params = {}

    build_query_params(params)
    build_query_user_params

    @conditions = []
    @conditions << User.arel_table[:username].matches("%#{@query_params[:login]}%") if @query_params[:login]
    @conditions << User.arel_table[:email].matches("%#{@query_params[:login]}%") if @query_params[:login]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
    end

    respond_to do |format|
      format.html { set_users_grid(@conditions) }
      format.json { render json: User.where(@conditions) }
    end
  end

  def build_query_params(parameters)
    QUERY_KEYS.each do |key|
      @query_params[key] = parameters[key] if parameters[key] && !parameters[key].empty?
    end
  end

  def build_query_user_params
    @query_user_params = User.new
    QUERY_KEYS.each do |key|
      @query_user_params.send("#{key}=", @query_params[key])
    end
  end

  def search
    @query_params = {}
    if request.post?
      build_query_params(params[:user])
      redirect_to users_path(@query_params)
    end
  end

  TABS = [:tab1, :tab2].freeze

  # GET /users/1
  # GET /users/1.json
  def show
    @tabs = TABS
    @current_tab = params[:tab]
    @current_tab ||= TABS.first.to_s
    @current_tab = @current_tab.to_sym
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_staff
  end

  # GET /users/1/edit
  def edit
    @user.build_staff if @user.staff.nil?
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params.except(:staff_attributes))
    staff = Staff.find(user_params[:staff_attributes][:id]) if user_params[:staff_attributes][:id] && !user_params[:staff_attributes][:id].empty?
    @user.staff = staff if staff

    respond_to do |format|
      if @user.save
        set_users_grid
        format.html { redirect_to users_path, notice: t('activerecord.success.messages.created', model: User.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      staff = Staff.find(user_params[:staff_attributes][:id]) if user_params[:staff_attributes][:id] && !user_params[:staff_attributes][:id].empty?
      @user.staff = staff if staff
      updating_params = user_params.except(:staff_attributes)
      updating_params = updating_params.except(:password, :password_confirmation) if user_params[:password].empty?
      if @user.update(updating_params)
        set_users_grid
        format.html { redirect_to users_path, notice: t('activerecord.success.messages.updated', model: User.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      set_users_grid
      format.html { redirect_to users_url, notice: t('activerecord.success.messages.destroyed', model: User.model_name.human) }
      format.js
    end
  end

  def upgrade_to_product_manager
    if request.post?
      respond_to do |format|
        @user.build_product_manager if @user.product_manager.nil?
        @user.product_manager.name = @user.name
        @user.save
        format.html { redirect_to users_url }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(
      :email,
      :encrypted_password,
      :reset_password_token,
      :reset_password_sent_at,
      :password,
      :password_confirmation,
      :remember_created_at,
      :sign_in_count,
      :current_sign_in_at,
      :last_sign_in_at,
      :current_sign_in_ip,
      :last_sign_in_ip,
      :username,
      :name,
      :role_ids => [],
      :staff_attributes => [
        :name,
        :id
      ]
      )
  end

  def set_users_grid(conditions = [])
    @users_grid = initialize_grid(User.where(conditions))
  end
end
