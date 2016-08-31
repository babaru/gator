class ConsultantsController < ApplicationController
  before_action :set_consultant, only: [:show, :edit, :update, :destroy]

  # GET /consultants
  # GET /consultants.json
  def index
    respond_to do |format|
      format.html do
        set_consultants_grid
      end

      format.json { render json: Consultant.all }
    end
  end

  # GET /consultants/1
  # GET /consultants/1.json
  def show
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

  def set_consultants_grid
    @consultants_grid = initialize_grid(Consultant)
  end
end
