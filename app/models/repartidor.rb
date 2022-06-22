class Repartidor
  attr_reader :nombre, :dni, :telefono, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, nombre, dni, telefono)
    validar_nombre(nombre)
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

  def validar_nombre(nombre)
    largo_nombre = nombre.delete(' ').length
    raise RepartidorInvalido if largo_nombre < 5
  end
end
