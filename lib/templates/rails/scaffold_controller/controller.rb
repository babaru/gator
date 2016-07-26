<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"
<% end -%>

<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  # GET <%= route_url %>
  # GET <%= route_url %>.json
  def index
    set_<%= plural_table_name %>_grid
  end

  # GET <%= route_url %>/1
  # GET <%= route_url %>/1.json
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= class_name.split('::').last %>.new
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  # POST <%= route_url %>.json
  def create
    @<%= singular_table_name %> = <%= class_name.split('::').last %>.new(<%= singular_table_name %>_params)

    respond_to do |format|
      if @<%= singular_table_name %>.save
        set_<%= plural_table_name %>_grid
        format.html { redirect_to @<%= singular_table_name %>, notice: t('activerecord.success.messages.created', model: <%= class_name.split('::').last %>.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT <%= route_url %>/1
  # PATCH/PUT <%= route_url %>/1.json
  def update
    respond_to do |format|
      if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
        set_<%= plural_table_name %>_grid
        format.html { redirect_to @<%= singular_table_name %>, notice: t('activerecord.success.messages.updated', model: <%= class_name.split('::').last %>.model_name.human) }
        format.js
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  # DELETE <%= route_url %>/1
  # DELETE <%= route_url %>/1.json
  def destroy
    @<%= singular_table_name %>.destroy

    respond_to do |format|
      set_<%= plural_table_name %>_grid
      format.html { redirect_to <%= index_helper %>_url, notice: t('activerecord.success.messages.destroyed', model: <%= class_name.split('::').last %>.model_name.human) }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= class_name.split('::').last %>.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def <%= singular_table_name %>_params
    params.require(:<%= singular_table_name %>).permit(
      <% class_name.split('::').last.constantize.columns.each_with_index do |item, index| %><% if item.name != "id" && item.name !="created_at" && item.name !="updated_at" %>:<%= item.name%>,
      <% end %><% end %>)
  end

  def set_<%= plural_table_name %>_grid
    @<%= plural_table_name %>_grid = initialize_grid(<%= class_name.split('::').last %>)
  end
end

<% end -%>
