class Menu
  attr_reader :updated_on, :created_on

  attr_accessor :id, :descripcion, :precio

  def initialize(id, descripcion, precio)
    validar(id, precio)

    @id = id
    @descripcion = descripcion
    @precio = precio
  end

  def validar(_id, precio)
    raise MenuInvalido if !precio.is_a?(Numeric) || precio.negative?
  end
end
