class ComprasController < ApplicationController
  skip_before_filter :verify_authenticity_token
#  before_filter :auth_admin, :only => [:create,:all,:update,:destroy,:create_many]
  http_basic_authenticate_with name: ENV['admin_user'], password: ENV['admin_pass'], except: [:index,:show]

  def all
    @compras = Compra.select('acto')

    respond_to do |format|
      format.json { render json: @compras }
    end
  end

  # GET /compras
  # GET /compras.json
  def index
    @compras = Compra.text_search(params[:query]).order('FECHA DESC')
    filter_compras
    stats
    @compras = @compras.paginate(page: params[:page])
    @entidades = Rails.cache.fetch("entidades", :expires_in => 1.day ) {Compra.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort}
    @compra_type = Rails.cache.fetch("compra_type", :expires_in => 1.day ) {Compra.select("DISTINCT(COMPRA_TYPE)").select{|x| x.compra_type != 'Licitaciуn Pъblica'}.map{|x| x.compra_type }.sort}
    @categories = Category.all
    record_query

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compras }
    end
  end

  # GET /compras/1
  # GET /compras/1.json
  def show
    @compra = Compra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @compra }
    end
  end

  # GET /compras/new
  # GET /compras/new.json
  def new
    @compra = Compra.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compra }
    end
  end

  # GET /compras/1/edit
  def edit
    @compra = Compra.find(params[:id])
  end

  # POST /compras
  # POST /compras.json
  def create
    @compra = Compra.new(params[:compra])

    respond_to do |format|
      if @compra.save
        format.html { redirect_to @compra, notice: 'Compra was successfully created.' }
        format.json { render json: @compra, status: :created, location: @compra }
      else
        format.html { render action: "new" }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compras/1
  # PUT /compras/1.json
  def update
    @compra = Compra.find(params[:id])

    respond_to do |format|
      if @compra.update_attributes(params[:compra])
        format.html { redirect_to @compra, notice: 'Compra was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compras/1
  # DELETE /compras/1.json
  def destroy
    @compra = Compra.find(params[:id])
    @compra.destroy

    respond_to do |format|
      format.html { redirect_to compras_url }
      format.json { head :no_content }
    end
  end

  def create_many
    respond_to do |format|
      if Compra.import initialize_many_from_json, :validate => false
        format.html { render text: 'success', status: :created}
        format.json { render text: 'success', status: :created}
      else
        format.html { render json: @compras.errors, status: :unprocessable_entity }
        format.json { render text: 'fail', status: :unprocessable_entity }
      end
    end
  end

  protected

  def auth_admin
    if params[:token] != '1zWRXH7m3kgV0CV3P8wxPXN1i6zgU2Bvm4mIpaA00lFmaswla9Qj5WIOAcNPSko' then
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def filter_fecha
    if params[:fecha_min] and params[:fecha_max] and (params[:fecha_max] != '' or params[:fecha_min] != '') then
      @compras = @compras.where('DATE(fecha) >= ?', params[:fecha_min]) if params[:fecha_min] != ''
      @compras = @compras.where('DATE(fecha) <= ?', params[:fecha_max]) if params[:fecha_max] != ''
    end
  end
  
  def filter_price
    if params[:price_min] and params[:price_max] and (params[:price_max] != '' or params[:price_min] != '') then
      @compras = @compras.where('precio >= ?', params[:price_min]) if params[:price_min] != ''
      @compras = @compras.where('precio <= ?', params[:price_max]) if params[:price_max] != ''
    end
  end

  def filter_proponente
    if params[:proponente] and params[:proponente] != '' then
      @compras = @compras.where("to_tsvector('simple',proponente) @@ plainto_tsquery('simple',?)", params[:proponente])
    end
  end

  def filter_acto
    if params[:acto] and params[:acto] != '' then
      @compras = @compras.where("acto = ?", params[:acto])
    end
  end

  def filter_modalidad
    if params[:modalidad] and params[:modalidad] != '' then
      @compras = @compras.where("modalidad = ?", params[:modalidad])
    end
  end

  def filter_objeto
    if params[:objeto] and params[:objeto] != '' then
      @compras = @compras.where("objeto = ?", params[:objeto])
    end
  end

  def filter_compra_type
    if params[:compra_type] and params[:compra_type] != '' then
      @compras = @compras.where("compra_type = ?", params[:compra_type])
    end
  end

  def filter_compras
    filter_fecha
    filter_price
    filter_proponente
    filter_acto
    filter_modalidad
    filter_objeto
    filter_compra_type
    @compras = @compras.where('entidad = ?', params[:entidad]) if (params[:entidad] and params[:entidad] != '')
    @compras = @compras.where('category_id = ?', params[:category]) if (params[:category] and params[:category] != '')
    @compras = @compras.where('proponente = ?', 'empty') if (params[:empty] and params[:empty] != '')
  end

  def stats
    @total = @compras.count
    @price = @compras.sum(:precio)
  end


  def record_query
    if params[:query] then
      query = { query: params[:query], ip: request.remote_ip }
      query['entidad'] = params[:entidad] if params[:entidad]
      query['user_id'] = current_user.id if user_signed_in?
      query['category_id'] = params[:category] if params[:category]
      query['price_min'] = params[:price_min] if params[:price_min]
      query['price_max'] = params[:price_max] if params[:price_max]
      query['empty'] = true if (params[:empty] and params[:empty] == '1') 
      Query.create(query)
    end
  end

end
