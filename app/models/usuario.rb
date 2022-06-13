class Usuario
  attr_reader :nombre, :telefono, :direccion, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, telefono, direccion)
    validar_telefono(telefono)
    validar_nombre(nombre)
    validar_direccion(direccion)

    @nombre = nombre
    @telefono = telefono
    @direccion = direccion
    @id = telefono
  end

  def validar_telefono(telefono)
    raise UsuarioInvalido if telefono !~ /^\d{10}$/
  end

  def validar_nombre(nombre)
    raise UsuarioInvalido if nombre !~ /^[a-zA-Z]{2,}$/
  end

  def validar_direccion(direccion)
    raise UsuarioInvalido if direccion.empty?
  end

  def ==(other)
    @nombre == other.nombre &&
      @telefono == other.telefono &&
      @direccion == other.direccion &&
      @id == other.id
  end
end
