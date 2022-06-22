class Repartidor
  attr_reader :nombre, :dni, :telefono, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, nombre, dni, telefono)
    validar_nombre(nombre)
    validar_telefono(telefono)
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
    raise RepartidorInvalido if largo_nombre < 5 || largo_nombre > 20
  end

  # En este caso telefono es un string
  def validar_telefono(telefono)
    raise RepartidorInvalido if telefono.to_i.to_s != telefono

    raise RepartidorInvalido if telefono.length != 10
  end
end
