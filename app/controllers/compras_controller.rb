class ComprasController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def all
    @compras = Compra.select('acto')

    respond_to do |format|
      format.json { render json: @compras }
    end
  end

  # GET /compras
  # GET /compras.json
  def index
    @compras = Compra.text_search(params[:query]).order('ID DESC')
    @compras = @compras.where('precio >= ?', params[:price_min]) if (params[:price_min] and params[:price_min] != '')
    @compras = @compras.where('precio <= ?', params[:price_max]) if (params[:price_max] and params[:price_max] != '')
    @compras = @compras.where('entidad = ?', params[:entidad]) if (params[:entidad] and params[:entidad] != '')
    @compras = @compras.where('category_id = ?', params[:category]) if (params[:category] and params[:category] != '')
    @compras = @compras.paginate(page: params[:page])
    @entidades = Compra.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort
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
    @compras = initialize_many_from_json

    respond_to do |format|
      if Compra.import @compras
        format.html { render json: @compras, status: :created}
        format.json { render json: @compras, status: :created}
      else
        format.html { render json: @compras.errors, status: :unprocessable_entity }
        format.json { render json: @compras.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def record_query
    if params[:query] then
      query = { query: params[:query], ip: request.remote_ip }
      query['entidad'] = params[:entidad] if params[:entidad]
      query['user_id'] = current_user.id if user_signed_in?
      query['category_id'] = params[:category] if params[:category]
      query['price_min'] = params[:price_min] if params[:price_min]
      query['price_max'] = params[:price_max] if params[:price_max]
      Query.create(query)
    end
  end

end
