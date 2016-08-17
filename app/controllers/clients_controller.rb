class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @query_params = {}
    if request.post?
      @query_params[:application_number] = params[:client][:application_number] if params[:client][:application_number] && !params[:client][:application_number].empty?
      @query_params[:id_number] = params[:client][:id_number] if params[:client][:id_number] && !params[:client][:id_number].empty?
      @query_params[:name] = params[:client][:name] if params[:client][:name] && !params[:client][:name].empty?
      @query_params[:type] = params[:client][:type] if params[:client][:type] && !params[:client][:type].empty?
    end

    @query_client_params = Client.new
    @query_client_params.application_number = @query_params[:application_number]
    @query_client_params.id_number = @query_params[:id_number]
    @query_client_params.name = @query_params[:name]
    @query_client_params.type = @query_params[:type]

    @conditions = []
    @conditions << Client.arel_table[:application_number].matches("%#{@query_params[:application_number]}%") if @query_params[:application_number]
    @conditions << Client.arel_table[:name].matches("%#{@query_params[:name]}%") if @query_params[:name]
    @conditions << Client.arel_table[:id_number].matches("%#{@query_params[:id_number]}%") if @query_params[:id_number]

    if @conditions.length > 0
      conditions = @conditions[0]
      @conditions.each_with_index do |item, index|
        conditions = conditions.or(item) if index > 0
      end
      @conditions = conditions
      @conditions = @conditions.and(Client.arel_table[:type].eq(@query_params[:type])) if @query_params[:type]
    else
      @conditions = Client.arel_table[:type].eq(@query_params[:type]) if @query_params[:type]
    end

    set_clients_grid(@conditions)
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    if !!params[:individual]
      @client = IndividualClient.new
    else
      @client = InstitutionClient.new
    end
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
      :type,
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

  def set_clients_grid(conditions)
    @clients_grid = initialize_grid(Client.where(conditions))
  end
end
