class AlertsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :through => :current_user
  # GET /alerts
  # GET /alerts.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alerts }
    end
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alert }
    end
  end

  # GET /alerts/new
  # GET /alerts/new.json
  def new
    @entidades = Compra.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alert }
    end
  end

  # GET /alerts/1/edit
  def edit
    @entidades = Compra.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort
  end

  # POST /alerts
  # POST /alerts.json
  def create
    @alert = current_user.alerts.new(params[:alert])

    respond_to do |format|
      if @alert.save
        format.html { redirect_to @alert, notice: 'Alert was successfully created.' }
        format.json { render json: @alert, status: :created, location: @alert }
      else
        format.html { render action: "new" }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alerts/1
  # PUT /alerts/1.json
  def update

    respond_to do |format|
      if @alert.update_attributes(params[:alert])
        format.html { redirect_to @alert, notice: 'Alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy

    respond_to do |format|
      format.html { redirect_to alerts_url }
      format.json { head :no_content }
    end
  end
end
