class Silla < ActiveRecord::Base
    
   def initialize(posicion, sala)
      
      @posicion=posicion
      @sala=sala
   end
end