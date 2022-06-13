class Usuario
  attr_reader :nombre, :telefono, :direccion, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, telefono, direccion)
    @nombre = nombre
    @telefono = telefono
    @direccion = direccion
    @id = telefono
  end

  def ==(other)
    @nombre == other.nombre &&
      @telefono == other.telefono &&
      @direccion == other.direccion &&
      @id == other.id
  end
end
