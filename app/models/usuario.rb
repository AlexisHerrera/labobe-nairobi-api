class Usuario
  attr_reader :nombre, :telefono, :direccion, :id_telegram, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, telefono, direccion, id_telegram)
    validar_telefono(telefono)
    validar_nombre(nombre)
    validar_direccion(direccion)
    validar_id_telegram(id_telegram)

    @nombre = nombre
    @telefono = telefono
    @id = telefono
    @direccion = direccion
    @id_telegram = id_telegram
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

  def validar_id_telegram(id_telegram)
    raise UsuarioInvalido if id_telegram.empty?
  end

  def ==(other)
    @nombre == other.nombre &&
      @telefono == other.telefono &&
      @direccion == other.direccion &&
      @id_telegram == other.id_telegram
  end
end
