class Repartidor
  attr_reader :nombre, :dni, :telefono, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, nombre, dni, telefono)
    @id = id
    @nombre = nombre
    @dni = dni
    @telefono = telefono
  end

  def ==(other)
    @id == other.id &&
      @nombre == other.nombre &&
      @telefono == other.telefono &&
      @dni == other.dni
  end
end
