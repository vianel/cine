class AsientosController < ApplicationController
  before_action :set_asiento, only: [:show, :edit, :update, :destroy]
  require 'matrix'
  
  def generarSala
    prng = Random.new
    @x = prng.rand(1..9) #Altura de la sala
    @y = prng.rand(1..9) #Ancho de la sala
   
    @sala = Matrix.build(@x, @y) { prng.rand(0..1) } #Generamos la sala aleatoriamente 0 ocupado 1 disponible
    return @sala
  end
  def seleccionarAsiento
    prng = Random.new
    asiento = 0
    matriz_vacia = Matrix.zero(@x, @y)
    if (@sala != matriz_vacia) #validamos que la sala no este full
      loop do 
        @fila = prng.rand(1..@x)
        @columna = prng.rand(1..@y)
        asiento = @sala[@fila, @columna]
        break if asiento == 1 
      end 
    end
    return asiento
  end
  
  def guardarasiento
    generarSala
    seleccionarAsiento
    
    @asiento = Asiento.new()
    
    Asiento.find_or_create_by(posicion: 'Fila ' + @fila.to_s + " Columna " + @columna.to_s, sala: @x*@y)
    #Guardamos el asiento seleccionado con su posicion y por efectos de prueba el tamaño de la sala
  
  end

  # GET /asientos
  # GET /asientos.json
  
  def index
    guardarasiento
    @asientos = Asiento.all
    
  end

  # GET /asientos/1
  # GET /asientos/1.json
  def show
    
  end

  # GET /asientos/new
  def new
    @asiento = Asiento.new
  end

  # GET /asientos/1/edit
  def edit
  end

  # POST /asientos
  # POST /asientos.json
  def create
    @asiento = Asiento.new(asiento_params)

    respond_to do |format|
      if @asiento.save
        format.html { redirect_to @asiento, notice: 'Asiento was successfully created.' }
        format.json { render :show, status: :created, location: @asiento }
      else
        format.html { render :new }
        format.json { render json: @asiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asientos/1
  # PATCH/PUT /asientos/1.json
  def update
    respond_to do |format|
      if @asiento.update(asiento_params)
        format.html { redirect_to @asiento, notice: 'Asiento was successfully updated.' }
        format.json { render :show, status: :ok, location: @asiento }
      else
        format.html { render :edit }
        format.json { render json: @asiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asientos/1
  # DELETE /asientos/1.json
  def destroy
    @asiento.destroy
    respond_to do |format|
      format.html { redirect_to asientos_url, notice: 'Asiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asiento
      @asiento = Asiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asiento_params
      params.require(:asiento).permit(:posicion, :sala)
    end
end
