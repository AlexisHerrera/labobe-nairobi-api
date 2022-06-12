class Usuario
  attr_reader :nombre, :telefono, :direccion, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, telefono, direccion)
    @nombre = nombre
    @telefono = telefono
    @direccion = direccion
    @id = telefono
  end
end
