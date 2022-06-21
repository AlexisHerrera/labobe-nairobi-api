class Repartidor
  attr_reader :nombre, :dni, :telefono
  attr_accessor :id

  def initialize(nombre, dni, telefono)
    @nombre = nombre
    @dni = dni
    @telefono = telefono
  end
end
