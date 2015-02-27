class SillasController < ApplicationController
 # before_action :set_asiento, only: [:show, :edit, :update, :destroy]
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
  
  def pruebasala
  #m = Matrix.build(3) { rand }
   # m = Matrix.build(2, 4) {|row, col| col - row }
    
    m = generarSala
    z = seleccionarAsiento

    @silla = Silla.new("asd",1)
    format.json { render json: @silla, status: :ok }
  
    
   
   
    
  end
end