class Menu
  attr_reader :updated_on, :created_on

  attr_accessor :id, :descripcion, :precio

  def initialize(id, descripcion, precio)
    validar(id, precio)

    @id = id
    @descripcion = descripcion
    @precio = precio
  end

  def validar(id, precio)
    raise MenuInvalido if !id.is_a?(Integer) || !precio.is_a?(Numeric) || precio.negative?
  end
end
